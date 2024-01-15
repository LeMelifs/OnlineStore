from database.database import get_session
from database.models import Size
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy import delete, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.v1.auth import admin_required, login_required

size_router = APIRouter()


@size_router.get("/view")
async def size_view(
    session: AsyncSession = Depends(get_session),
):
    sizes = [x[0] for x in (await session.execute(select(Size))).all()]

    return sizes


@size_router.post("/add")
async def size_add(
    request: Request,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        name = data["name"]

    except:
        raise HTTPException(400, "Некорректный запрос")

    size_rep = (await session.execute(select(Size).where(Size.name == name))).first()

    if size_rep != None:
        raise HTTPException(400, "Такой размер уже существует")

    size_ins = {"name": name}

    await session.execute(insert(Size).values(size_ins))
    await session.commit()

    return {"detail": "Размер успешно добавлен"}


@size_router.post("/delete")
async def size_delete(
    size_id: int,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    await session.execute(delete(Size).where(Size.id == size_id))
    await session.commit()

    return {"detail": "Размер успешно удален"}
