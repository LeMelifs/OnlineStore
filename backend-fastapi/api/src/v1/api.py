import os

from config import IMG_PATH
from database.database import get_session
from database.models import Photo, User
from fastapi import APIRouter, Depends, HTTPException, UploadFile
from fastapi.responses import FileResponse
from sqlalchemy import delete, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_maker, time
from src.v1.auth import admin_required, auth_router, login_required
from src.v1.user import user_router

router = APIRouter()

router.include_router(user_router, prefix="/user")
router.include_router(auth_router, prefix="/auth")


@router.get("/img")
async def file_reciever(
    img: str = None,
):
    path = f"{IMG_PATH}/{img}"
    try:
        os.stat(path)
        return FileResponse(path=f"{IMG_PATH}/{img}")
    except:
        raise HTTPException(status_code=404, detail="image not found")


@router.get("/forum")
async def forum():
    return "https://t.me/+6VdMCPodJRYxNTUy"


@router.get("/healthcheck")
async def index(session: AsyncSession = Depends(get_session)):
    try:
        await session.execute(select(User))
        return {"detail": "server works!!!!"}
    except Exception as e:
        print(e)
        return {"detail": "connection to the database is corrupted"}


@router.get("/check_token")
async def token_checker(user=Depends(login_required)):
    return {"detail": "token is ok"}


@router.post("/upload")
async def upload(
    files: list[UploadFile],
    building_id: int = None,
    area_id: int = None,
    category_id: int = None,
    service_id: int = None,
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    user_id = None

    for file in files:
        contents = file.file.read()

        if all(x == None for x in [area_id, building_id, category_id, service_id]):
            folder = "client"
            id = user.id
            user_id = id
        elif building_id != None and all(
            x == None for x in [area_id, user_id, category_id, service_id]
        ):
            folder = "building"
            id = building_id
        elif area_id != None and all(
            x == None for x in [user_id, building_id, category_id, service_id]
        ):
            folder = "area"
            id = area_id
        elif category_id != None and all(
            x == None for x in [area_id, building_id, user_id, service_id]
        ):
            folder = "category"
            id = category_id
        elif service_id != None and all(
            x == None for x in [area_id, building_id, category_id, user_id]
        ):
            folder = "service"
            id = service_id
        else:
            raise HTTPException(status_code=400, detail="wrong parameters")

        try:
            os.stat(f"{IMG_PATH}/{folder}")
        except:
            os.mkdir(f"{IMG_PATH}/{folder}")

        try:
            os.stat(f"{IMG_PATH}/{folder}/{id}")
        except:
            os.mkdir(f"{IMG_PATH}/{folder}/{id}")

        x = True
        y = str(id) + "_0"
        z = 1

        try:
            while x:
                try:
                    os.stat(f"{IMG_PATH}/{folder}/{id}/{y}.jpg")
                    y = f"{id}_{z}"
                    z += 1
                except:
                    x = False

                    with open(f"{IMG_PATH}/{folder}/{id}/{y}.jpg", "wb") as f:
                        f.write(contents)

                    photo_maker(f"{IMG_PATH}/{folder}/{id}/{y}.jpg")

            photo = {
                "obj": folder,
                "obj_id": id,
                "path": f"{folder}/{id}/{y}.jpg",
                "time": time(),
            }

            await session.execute(insert(Photo).values(photo))
            await session.commit()

        except Exception as e:
            print(e)
            raise HTTPException(status_code=500, detail="smth gone wrong")

    return {"detail": "img upload success"}


@router.post("/img_delete")
async def img_delete(
    path: str,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    photo_raw = (
        await session.execute(select(Photo.id).where(Photo.path == path))
    ).first()

    if photo_raw == None:
        raise HTTPException(
            status_code=400,
            detail="img not found",
        )

    photo = photo_raw._mapping

    stmt = delete(Photo).where(Photo.id == photo["id"])

    os.remove(f"{IMG_PATH}/{path}")

    await session.execute(stmt)
    await session.commit()

    return {"detail": "img delete success"}
