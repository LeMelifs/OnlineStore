import os
from src.v1.external import send_email

from config import IMG_PATH
from database.database import get_session
from database.models import Photo, User
from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException, UploadFile
from fastapi.responses import FileResponse
from sqlalchemy import delete, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_maker, time
from src.v1.auth import admin_required, auth_router, login_required
from src.v1.user import user_router
from src.v1.category import category_router
from src.v1.bin import bin_router
from src.v1.city import city_router
from src.v1.pickpoint import pickpoint_router
from src.v1.product import product_router

router = APIRouter()

router.include_router(user_router, prefix="/user")
router.include_router(auth_router, prefix="/auth")
router.include_router(category_router, prefix="/category")
router.include_router(bin_router, prefix="/bin")
router.include_router(city_router, prefix="/city")
router.include_router(pickpoint_router, prefix="/pickpoint")
router.include_router(product_router, prefix="/product")


@router.get("/")
async def file_reciever(
    img: str = None,
):
    path = f"{IMG_PATH}/{img}"
    try:
        os.stat(path)
        return FileResponse(path=f"{IMG_PATH}/{img}")
    except:
        raise HTTPException(status_code=404, detail="Изображение не найдено")


@router.get("/healthcheck")
async def index(session: AsyncSession = Depends(get_session)):
    try:
        await session.execute(select(User))
        return {"detail": "ok"}
    except Exception as e:
        print(e)
        return {"detail": "error"}


@router.get("/check_token")
async def token_checker(user=Depends(login_required)):
    return {"detail": "Токен корректен"}


@router.post("/upload")
async def upload(
    files: list[UploadFile],
    product_id: int = None,
    category_id: int = None,
    pickpoint_id: int = None,
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    for file in files:
        contents = file.file.read()

        if product_id != None and all(x == None for x in [category_id, pickpoint_id]):
            folder = "product"
            id = product_id
        elif category_id != None and all(x == None for x in [product_id, pickpoint_id]):
            folder = "category"
            id = category_id
        elif pickpoint_id != None and all(x == None for x in [product_id, category_id]):
            folder = "pickpoint"
            id = category_id
        else:
            raise HTTPException(status_code=400, detail="Некорректные параметры")

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
            raise HTTPException(status_code=500, detail="Что-то пошло не так")

    return {"detail": "Добавление фотографии успешно"}


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
            detail="Изображение не найдено",
        )

    photo = photo_raw._mapping

    stmt = delete(Photo).where(Photo.id == photo["id"])

    os.remove(f"{IMG_PATH}/{path}")

    await session.execute(stmt)
    await session.commit()

    return {"detail": "Удаление фотографии успешно"}
