import os
from datetime import datetime, timedelta
from random import randint

import ujson
from database.database import get_session
from database.models import ChangePasswordCode, Photo
from fastapi import Depends, HTTPException, Response
from PIL import Image
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
        phone_number = "+7" + phone_number[1:]

    if len(phone_number) != 12:
        response = Response(
            content=ujson.dumps({"status": "fail", "msg": "wrong phone number format"}),
            status_code=400,
        )
        response.headers["Content-Type"] = "application/json"
        return response

    return phone_number


def photo_maker(path: str):
    try:
        os.stat(path)
    except:
        raise HTTPException(status_code=400, detail="img not found")

    src = Image.open(path)

    scale_percent = 95

    try:
        width = int(src.shape[1] * scale_percent / 100)
        height = int(src.shape[0] * scale_percent / 100)

        while width > 2000 and height > 2000:
            scale_percent -= 5

            width = int(src.shape[1] * scale_percent / 100)
            height = int(src.shape[0] * scale_percent / 100)

        dsize = (width, height)

        output = src.resize(dsize)

        output.save(path)

        image = Image.open(path)

        data = list(image.getdata())
        image_without_exif = Image.new(image.mode, image.size)
        image_without_exif.putdata(data)

        image_without_exif.save(path)

        image_without_exif.close()

        return "positive"

    except:
        raise HTTPException(status_code=400, detail="incorrect img")


async def photo_search(
    obj: str, obj_id: int, session: AsyncSession = Depends(get_session)
):
    PHOTO_HOST = "https://onlinestore.poslam.ru/api/v1/?img="

    allowed_objs = ["area", "building", "client", "category", "service"]

    if obj not in allowed_objs:
        raise HTTPException(status_code=400, detail="obj not allowed")

    stmt = select(Photo.path).where(Photo.obj == obj).where(Photo.obj_id == obj_id)

    if obj == "client":
        stmt = stmt.order_by(desc(Photo.time))

    photos = (await session.execute(stmt)).all()

    result = []

    for photo_raw in photos:
        photo = photo_raw._mapping["path"]

        result.append(PHOTO_HOST + photo)

    return result
