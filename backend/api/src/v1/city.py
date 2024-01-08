from database.database import get_session
from database.models import Category, City
from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.responses import FileResponse
from sqlalchemy import delete, desc, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_maker, time
from src.v1.auth import admin_required, login_required

city_router = APIRouter()


@city_router.get("/view")
async def city_view(
    user=Depends(login_required), session: AsyncSession = Depends(get_session)
):
    cities = [x[0] for x in (await session.execute(select(City))).all()]

    return cities


@city_router.post("/add")
async def city_add(
    request: Request,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        name = data["name"]

    except:
        raise HTTPException(400, "Некорректный запрос")

    city_check = (await session.execute(select(City).where(City.name == name))).first()

    if city_check != None:
        raise HTTPException(400, "Такой город уже существует")

    city_insert = {"name": name}

    await session.execute(insert(City).values(city_insert))
    await session.commit()

    return {"detail": "Добавление города успешно"}
