from database.database import get_session
from database.models import Bin, Color, Product, ProductColor, ProductSize, Size
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import delete, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_search
from src.v1.auth import login_required

bin_router = APIRouter()


@bin_router.get("/view")
async def bin_view(
    user=Depends(login_required), session: AsyncSession = Depends(get_session)
):
    result = []
    sum = 0

    products = (await session.execute(select(Bin).where(Bin.user_id == user.id))).all()

    for product_bin_raw in products:
        product_bin = product_bin_raw[0]

        product = await session.get(Product, product_bin.product_id)
        size = await session.get(Size, product_bin.size_id)
        color = await session.get(Color, product_bin.color_id)

        sum += product.price

        product.photo = await photo_search("product", product.id, session)
        product.size = {"id": size.id, "name": size.name}
        product.color = {
            "id": color.id,
            "name": color.name,
            "hex_code": color.hex_code,
        }

        result.append(product)

    return {"sum": sum, "count": len(result), "products": result}


@bin_router.post("/add")
async def bin_add(
    product_id: int,
    color_id: int,
    size_id: int,
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    product = await session.get(Product, product_id)

    if product == None:
        raise HTTPException(400, "Товар не найден")

    size = await session.execute(
        select(ProductSize)
        .where(ProductSize.size_id == size_id)
        .where(ProductSize.product_id == product_id)
    )

    if size == None:
        raise HTTPException(400, "Размер для данного товара не найден")

    color = await session.execute(
        select(ProductColor)
        .where(ProductColor.color_id == color_id)
        .where(ProductColor.product_id == product_id)
    )

    if color == None:
        raise HTTPException(400, "Цвет для данного товара не найден")

    bin_ins = {
        "user_id": user.id,
        "product_id": product_id,
        "size_id": size_id,
        "color_id": color_id,
    }

    await session.execute(insert(Bin).values(bin_ins))
    await session.commit()

    return {"detail": "Товар успешно добавлен в корзину"}


@bin_router.post("/delete")
async def bin_delete(
    product_id: int,
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    bin_product = (
        await session.execute(
            select(Bin)
            .where(Bin.user_id == user.id)
            .where(Bin.product_id == product_id)
        )
    ).first()

    if bin_product == None:
        raise HTTPException(400, "Товар в корзине не найден")

    await session.execute(delete(Bin).where(Bin.id == bin_product[0].id))
    await session.commit()

    return {"detail": "Товар успешно удален из корзины"}
