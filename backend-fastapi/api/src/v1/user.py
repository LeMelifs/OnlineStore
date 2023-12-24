from database.database import get_session
from database.models import User
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import update
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_search
from src.v1.auth import admin_required, login_required

user_router = APIRouter()


@user_router.get("/view")
async def user_view(
    user: User = Depends(login_required), session: AsyncSession = Depends(get_session)
):
    result = {
        "username": user.username,
        "first_name": user.first_name,
        "second_name": user.second_name,
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
            detail="user not found",
        )

    await session.execute(update(User).where(User.id == user_id).values(active=False))
    await session.commit()

    return {"detail": "user ban success"}
