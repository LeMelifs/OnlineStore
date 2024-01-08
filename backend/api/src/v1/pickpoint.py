from database.database import get_session
from database.models import Category, City, PickPoint
from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.responses import FileResponse
from sqlalchemy import delete, desc, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_maker, photo_search, time
from src.v1.auth import admin_required, login_required

pickpoint_router = APIRouter()


@pickpoint_router.get("/view")
async def pickpoint_view(
    user=Depends(login_required), session: AsyncSession = Depends(get_session)
):
    result = []

    pickpoints_raw = (
        await session.execute(
            select(PickPoint.id, PickPoint.name, City.name.label("city_name")).where(
                PickPoint.city_id == City.id
            )
        )
    ).all()

    for pickpoint_raw in pickpoints_raw:
        pickpoint = dict(pickpoint_raw._mapping)

        pickpoint["photo"] = await photo_search("pickpoint", pickpoint["id"], session)

        result.append(pickpoint)

    return result


@pickpoint_router.post("/add")
async def pickpoint_add(
    request: Request,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        name = data["name"]
        city_id = data["city_id"]

    except:
        raise HTTPException(400, "Некорректный запрос")

    pickpoint_check = (
        await session.execute(
            select(PickPoint)
            .where(PickPoint.name == name)
            .where(PickPoint.city_id == city_id)
        )
    ).first()

    if pickpoint_check != None:
        raise HTTPException(400, "Такая точка выдачи уже существует")

    pickpoint_insert = {"name": name, "city_id": city_id}

    await session.execute(insert(PickPoint).values(pickpoint_insert))
    await session.commit()

    return {"detail": "Добавление точки выдачи успешно"}
