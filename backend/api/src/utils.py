from datetime import datetime, timedelta
from random import randint

from config import HOST
from database.database import get_session
from database.models import ChangePasswordCode, Photo
from fastapi import Depends, HTTPException
from sqlalchemy import desc, select
from sqlalchemy.ext.asyncio import AsyncSession


def time():
    return datetime.utcnow() + timedelta(hours=10)


async def code_generator(session: AsyncSession = Depends(get_session)):
    all_codes_raw = (await session.execute(select(ChangePasswordCode.code))).all()

    all_codes = [code._mapping["code"] for code in all_codes_raw]

    code = str(randint(100000, 999999))

    while code in all_codes:
        code = str(randint(100000, 999999))

    return code


def phone_check(phone_number: str):
    if phone_number[0] in ["8", "7"]:
        phone_number = "+7" + phone_number[1:].lstrip(" ").rstrip(" ")

    phone_number = phone_number.replace("-", "").replace(" ", "")

    if len(phone_number) != 12:
        raise HTTPException(400, f"wrong phone number format: {phone_number}")

    return phone_number


async def photo_search(
    obj: str, obj_id: int, session: AsyncSession = Depends(get_session)
):
    PHOTO_HOST = f"{HOST}/api/v1/?img="

    allowed_objs = ["category", "product", "pickpoint", "client"]

    if obj not in allowed_objs:
        raise HTTPException(status_code=400, detail="Некорректный тип объекта")

    stmt = select(Photo.path).where(Photo.obj == obj).where(Photo.obj_id == obj_id)

    if obj == "client":
        stmt = stmt.order_by(desc(Photo.time))

    photos = (await session.execute(stmt)).all()

    result = []

    for photo_raw in photos:
        photo = photo_raw._mapping["path"]

        result.append(PHOTO_HOST + photo)

    return result
