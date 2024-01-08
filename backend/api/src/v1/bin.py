from database.database import get_session
from database.models import Category
from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.responses import FileResponse
from sqlalchemy import delete, desc, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_maker, time
from src.v1.auth import admin_required, login_required

bin_router = APIRouter()


@bin_router.get("/view")
async def bin_view(
    user=Depends(login_required), session: AsyncSession = Depends(get_session)
):
    pass
