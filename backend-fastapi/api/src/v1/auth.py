from datetime import datetime, timedelta

from config import (
    ALGORITHM,
    AUTH_TOKEN_LIFE,
    REFRESH_TOKEN_LIFE,
    RT_SECRET,
    SECRET_AUTH,
)
from database.database import get_session
from database.models import ChangePasswordCode, RefreshTokenStorage, User
from fastapi import APIRouter, BackgroundTasks, Depends, Header, HTTPException, Request
from jwt import decode, encode
from sqlalchemy import delete, func, insert, select, update
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import code_generator, phone_check, time
from src.v1.external import send_email
from werkzeug.security import check_password_hash, generate_password_hash

auth_router = APIRouter()


async def type_required(
    types: list, auth: str = Header(None), session: AsyncSession = Depends(get_session)
):
    data = None
    try:
        data = decode(auth, SECRET_AUTH, algorithms=[ALGORITHM])

        token_expired_time = datetime.strptime(data["expired"], "%Y-%m-%d %H:%M:%S.%f")

        if token_expired_time < time():
            raise Exception

    except:
        raise HTTPException(status_code=401, detail="Некорректный токен")

    user = await session.get(User, data["id"])

    if user == None:
        raise HTTPException(status_code=400, detail="Пользователь не найден")

    if user.active == False:
        raise HTTPException(status_code=401, detail="Пользователь заблокирован")

    if user.type.name not in types and types != []:
        raise HTTPException(status_code=400, detail="Недопустимый тип пользвателя")

    return user


async def login_required(
    auth: str = Header(None), session: AsyncSession = Depends(get_session)
):
    return await type_required([], auth, session)


async def admin_required(
    auth: str = Header(None), session: AsyncSession = Depends(get_session)
):
    return await type_required(["admin"], auth, session)


def make_token(user_id: int):
    return encode(
        {"id": user_id, "expired": str(time() + timedelta(hours=int(AUTH_TOKEN_LIFE)))},
        SECRET_AUTH,
    )


def make_refresh_token(user_id: int):
    return encode(
        {
            "id": user_id,
            "expired": str(time() + timedelta(days=int(REFRESH_TOKEN_LIFE))),
        },
        RT_SECRET,
    )


@auth_router.post("/login")
async def login_func(request: Request, session: AsyncSession = Depends(get_session)):
    try:
        data = await request.json()

        login = data["login"].lstrip(" ").rstrip(" ")

        password = data["password"].lstrip(" ").rstrip(" ")
    except:
        raise HTTPException(status_code=400, detail="Некорректный запрос")

    stmt = select(User.active, User.password, User.id, User.type).where(
        func.lower(User.username) == login.lower()
    )

    user = (await session.execute(stmt)).first()

    if user != None:
        user = user._mapping

    else:
        raise HTTPException(
            status_code=400,
            detail="Пользователь не найден",
        )

    if user["active"] == False:
        raise HTTPException(
            status_code=401,
            detail="Пользователь заблокирован",
        )

    if not check_password_hash(user["password"], password):
        raise HTTPException(
            status_code=400,
            detail="Некорретные данные",
        )

    token = make_token(user["id"])

    refresh_token = make_refresh_token(user["id"])

    return {
        "token": token,
        "refresh_token": refresh_token,
        "type": user["type"].name,
    }


@auth_router.post("/refresh")
async def refresh(request: Request, session: AsyncSession = Depends(get_session)):
    try:
        data = await request.json()

        refresh_token_recieved = data["refresh_token"]

        token_data = decode(refresh_token_recieved, RT_SECRET, algorithms=[ALGORITHM])

        token_expired_time = datetime.strptime(
            token_data["expired"], "%Y-%m-%d %H:%M:%S.%f"
        )

        if token_expired_time < time():
            raise Exception

    except:
        raise HTTPException(
            status_code=400,
            detail="Некорретный токен",
        )

    tokens = (
        await session.execute(
            select(
                RefreshTokenStorage.id,
                RefreshTokenStorage.refresh_token,
                RefreshTokenStorage.expired,
            )
        )
    ).all()

    for token in tokens:
        token = token._mapping

        if token["expired"] < time():
            await session.execute(
                delete(RefreshTokenStorage).where(RefreshTokenStorage.id == token["id"])
            )
            await session.commit()

        if token["refresh_token"] == refresh_token_recieved:
            raise HTTPException(
                status_code=400,
                detail="Некорректный токен",
            )

    user_id = token_data["id"]

    user = await session.get(User, user_id)

    if user.active == False:
        raise HTTPException(
            status_code=401,
            detail="Пользователь заблокирован",
        )

    token = make_token(user_id)

    refresh_token = make_refresh_token(user_id)

    user_type = (await session.get(User, user_id)).type.name

    await session.execute(
        insert(RefreshTokenStorage).values(
            {"refresh_token": refresh_token_recieved, "expired": token_expired_time}
        )
    )

    await session.commit()

    return {
        "token": token,
        "refresh_token": refresh_token,
        "type": user_type,
    }


@auth_router.post("/signup")
async def signup(request: Request, session: AsyncSession = Depends(get_session)):
    try:
        data = await request.json()

        username = data["username"].lstrip(" ").rstrip(" ")
        first_name = data["first_name"].lstrip(" ").rstrip(" ")
        gender = data["gender"]
        email = data["email"].lstrip(" ").rstrip(" ")
        phone_number = data["phone_number"].lstrip(" ").rstrip(" ")
        password = data["password"]
    except:
        raise HTTPException(
            status_code=400,
            detail="Некорректный запрос",
        )

    stmt = select(User).where(func.lower(User.email) == email.lower())
    user = (await session.execute(stmt)).first()

    username_check = (
        await session.execute(select(User).where(User.username == username))
    ).first()

    if user != None or username_check != None:
        raise HTTPException(
            status_code=400,
            detail="Пользователь уже существует",
        )

    if "@" not in email or "." not in email:
        raise HTTPException(
            status_code=400,
            detail="Некорректная почта",
        )

    if phone_number not in [None, " ", ""]:
        phone_number = phone_check(phone_number)

        phone_number_check = (
            await session.execute(select(User).where(User.phone_number == phone_number))
        ).first()

        if phone_number_check != None:
            raise HTTPException(
                status_code=400,
                detail="Номер телефона уже занят",
            )

    else:
        phone_number = None

    if gender not in ["m", "f"]:
        raise HTTPException(status_code=400, detail="Некорректный пол")

    user = {
        "username": username,
        "first_name": first_name,
        "gender": gender,
        "email": email,
        "phone_number": phone_number,
        "password": generate_password_hash(password),
        "register_date": time(),
    }

    stmt = insert(User).values(user)

    await session.execute(stmt)
    await session.commit()

    return {"detail": "Пользователь успешно зарегистрирован"}


@auth_router.post("/forgot_password")
async def forgot_password(
    back: BackgroundTasks,
    email: str = None,
    code: str = None,
    password: str = None,
    session: AsyncSession = Depends(get_session),
):
    if email != None and code == None and password == None:
        user = (
            await session.execute(select(User.id).where(User.email == email))
        ).first()

        if user == None:
            raise HTTPException(
                status_code=400,
                detail="Пользователь не найден",
            )

        code = await code_generator(session)

        await session.execute(
            insert(ChangePasswordCode).values(
                email=email, code=code, exp_date=time() + timedelta(minutes=10)
            )
        )
        await session.commit()

        text = "Ваш код для восстановления пароля: " + code

        back.add_task(send_email, text, email, "Восстановление пароля onlinestore")

        return {"detail": "Письмо отправлено"}

    elif email != None and code != None and password == None:
        temp = (
            await session.execute(
                select(ChangePasswordCode.id, ChangePasswordCode.exp_date)
                .where(ChangePasswordCode.email == email)
                .where(ChangePasswordCode.code == code)
            )
        ).first()

        if temp == None:
            raise HTTPException(
                status_code=400,
                detail="Некорректный код или email",
            )

        obj = temp._mapping

        if obj["exp_date"] < time():
            raise HTTPException(
                status_code=400,
                detail="code is expired",
            )

        return {"detail": "Код корректен"}

    elif email != None and code != None and password != None:
        temp = (
            await session.execute(
                select(ChangePasswordCode.id, ChangePasswordCode.exp_date)
                .where(ChangePasswordCode.email == email)
                .where(ChangePasswordCode.code == code)
            )
        ).first()

        if temp == None:
            raise HTTPException(
                status_code=400,
                detail="Некорректный код или email",
            )

        obj = temp._mapping

        if obj["exp_date"] < time():
            raise HTTPException(
                status_code=400,
                detail="Код истек",
            )

        await session.execute(
            delete(ChangePasswordCode).where(ChangePasswordCode.id == obj["id"])
        )
        await session.commit()

        (
            await session.execute(
                update(User)
                .where(User.email == email)
                .values(password=generate_password_hash(password))
            )
        )
        await session.commit()

        return {"detail": "Смена пароля завершена успешно"}

    else:
        raise HTTPException(
            status_code=400,
            detail="Некорректные параметры",
        )


@auth_router.post("/email_verify")
async def email_verify(
    back: BackgroundTasks,
    email: str = None,
    code: str = None,
    session: AsyncSession = Depends(get_session),
):
    if email != None and code == None:
        user = (
            await session.execute(select(User.id).where(User.email == email))
        ).first()

        if user == None:
            raise HTTPException(
                status_code=400,
                detail="Пользователь не найден",
            )

        code = await code_generator(session)

        await session.execute(
            insert(ChangePasswordCode).values(
                email=email, code=code, exp_date=time() + timedelta(minutes=10)
            )
        )
        await session.commit()

        text = "Ваш код для подтверждения почты: " + code

        back.add_task(send_email, text, email, "Подтверждение почты onlinestore")

        return {"detail": "Письмо отправлено"}

    elif email != None and code != None:
        temp = (
            await session.execute(
                select(ChangePasswordCode.id, ChangePasswordCode.exp_date)
                .where(ChangePasswordCode.email == email)
                .where(ChangePasswordCode.code == code)
            )
        ).first()

        if temp == None:
            raise HTTPException(
                status_code=400,
                detail="Некорректный код или email",
            )

        obj = temp._mapping

        if obj["exp_date"] < time():
            raise HTTPException(
                status_code=400,
                detail="Код истек",
            )

        await session.execute(
            update(User).where(User.email == email).values(verified=True)
        )
        await session.commit()

        await session.execute(
            delete(ChangePasswordCode).where(ChangePasswordCode.id == obj["id"])
        )
        await session.commit()

        return {"detail": "Почта подтверждена"}

    else:
        raise HTTPException(
            status_code=400,
            detail="Некорректные параметры",
        )


@auth_router.post("/change_password")
async def change_password(
    request: Request,
    user: User = Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        old = data["old"].lstrip(" ").rstrip(" ")
        new = data["new"].lstrip(" ").rstrip(" ")

    except:
        raise HTTPException(
            status_code=400,
            detail="Некорректный запрос",
        )

    if not check_password_hash(user.password, old):
        raise HTTPException(
            status_code=400,
            detail="Некорретные данные",
        )

    await session.execute(
        update(User)
        .where(User.id == user.id)
        .values(password=generate_password_hash(new))
    )
    await session.commit()

    return {"detail": "Пароль успешно изменен"}
