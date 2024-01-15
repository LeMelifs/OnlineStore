from database.database import get_session
from database.models import Color
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy import delete, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.v1.auth import admin_required, login_required

color_router = APIRouter()


@color_router.get("/view")
async def color_view(
    session: AsyncSession = Depends(get_session),
):
    colors = [x[0] for x in (await session.execute(select(Color))).all()]

    return colors


@color_router.post("/add")
async def color_add(
    request: Request,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        name = data["name"]
        hex_code = data["hex_code"]

    except:
        raise HTTPException(400, "Некорректный запрос")

    color_rep = (
        await session.execute(select(Color).where(Color.hex_code == hex_code))
    ).first()

    if color_rep != None:
        raise HTTPException(400, "Такой цвет уже существует")

    color_ins = {"name": name, "hex_code": hex_code}

    await session.execute(insert(Color).values(color_ins))
    await session.commit()

    return {"detail": "Цвет успешно добавлен"}


@color_router.post("/delete")
async def color_delete(
    color_id: int,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    await session.execute(delete(Color).where(Color.id == color_id))
    await session.commit()

    return {"detail": "Цвет успешно удален"}
