from database.database import get_session
from database.models import Category
from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.responses import FileResponse
from sqlalchemy import delete, desc, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import time
from src.v1.auth import admin_required, login_required

product_router = APIRouter()


@product_router.get("/view")
async def category_view(
    user=Depends(login_required), session: AsyncSession = Depends(get_session)
):
    categories = [x[0] for x in (await session.execute(select(Category))).all()]

    return categories
