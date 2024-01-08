from database.database import get_session
from database.models import User
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy import select, update
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import phone_check, photo_search
from src.v1.auth import admin_required, login_required

user_router = APIRouter()


@user_router.get("/view")
async def user_view(
    user: User = Depends(login_required), session: AsyncSession = Depends(get_session)
):
    result = {
        "username": user.username,
        "first_name": user.first_name,
        "email": user.email,
        "type": user.type.name,
        "gender": user.gender,
        "photo": await photo_search("client", user.id, session),
        "phone_number": user.phone_number,
        "active": user.active,
    }

    return result


@user_router.post("/ban")
async def user_ban(
    user_id: int,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    user = await session.get(User, user_id)

    if user == None:
        raise HTTPException(
            status_code=400,
            detail="Пользователь не найден",
        )

    await session.execute(update(User).where(User.id == user_id).values(active=False))
    await session.commit()

    return {"detail": "Пользователь заблокирован успешно"}


@user_router.post("/edit")
async def user_edit(
    request: Request,
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()
    except:
        raise HTTPException(
            status_code=400,
            detail="Некорректный запрос",
        )

    for i in data:
        if i == "username":
            username_check = (
                await session.execute(select(User).where(User.username == data[i]))
            ).first()

            if username_check != None:
                raise HTTPException(
                    status_code=400,
                    detail="username занят",
                )

            stmt = update(User).where(User.id == user.id).values(username=data[i])

        elif i == "first_name":
            stmt = update(User).where(User.id == user.id).values(first_name=data[i])

        elif i == "email":
            if "@" not in data[i] and "." not in data[i]:
                raise HTTPException(
                    status_code=400,
                    detail="Некорректная почта",
                )

            stmt = update(User).where(User.id == user.id).values(email=data[i])

        elif i == "phone_number":
            phone_number = data[i]

            phone_number = phone_check(phone_number)

            phone_number_check = (
                await session.execute(
                    select(User).where(User.phone_number == phone_number)
                )
            ).first()

            if phone_number_check != None:
                raise HTTPException(
                    status_code=400,
                    detail="Номер телефона уже занят",
                )

            stmt = (
                update(User).where(User.id == user.id).values(phone_number=phone_number)
            )

        elif i == "gender":
            if data[i] not in ["m", "f"]:
                raise HTTPException(
                    status_code=400,
                    detail="Некорректный пол",
                )
            stmt = update(User).where(User.id == user.id).values(gender=data[i])

        else:
            raise HTTPException(
                status_code=400,
                detail="Некорректный запрос",
            )

        await session.execute(stmt)
        await session.commit()

    return {"detail": "Изменение данных пользователя успешно"}
