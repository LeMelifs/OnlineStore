from database.database import get_session
from database.models import Category
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy import insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_search
from src.v1.auth import admin_required, login_required

category_router = APIRouter()


@category_router.get("/view")
async def category_view(
    user=Depends(login_required), session: AsyncSession = Depends(get_session)
):
    result = []

    categories_raw = (await session.execute(select(Category))).all()

    for category_raw in categories_raw:
        category: Category = category_raw[0]

        category.photo = await photo_search("category", category.id, session)

        result.append(category)

    return result


@category_router.post("/add")
async def category_add(
    request: Request,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        name = data["name"]

    except:
        raise HTTPException(400, "Некорректный запрос")

    category_check = (
        await session.execute(select(Category).where(Category.name == name))
    ).first()

    if category_check != None:
        raise HTTPException(400, "Такая категория уже существует")

    category_insert = {"name": name}

    await session.execute(insert(Category).values(category_insert))
    await session.commit()

    return {"detail": "Добавление категории успешно"}
