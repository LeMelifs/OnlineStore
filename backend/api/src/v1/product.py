from database.database import get_session
from database.models import (
    Category,
    Color,
    Product,
    ProductColor,
    ProductSize,
    Size,
)
from fastapi import APIRouter, Depends, HTTPException, Request
from sqlalchemy import delete, insert, select
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_search
from src.v1.auth import admin_required, login_required

product_router = APIRouter()


@product_router.get("/view")
async def product_view(
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    result = []

    products_raw = (await session.execute(select(Product))).all()

    for product_raw in products_raw:
        product: Product = product_raw[0]

        sizes = []
        colors = []

        product_sizes = (
            await session.execute(
                select(ProductSize).where(ProductSize.product_id == product.id)
            )
        ).all()

        product_colors = (
            await session.execute(
                select(ProductColor).where(ProductColor.product_id == product.id)
            )
        ).all()

        for product_size_raw in product_sizes:
            product_size: ProductSize = product_size_raw[0]

            size = await session.get(Size, product_size.size_id)

            sizes.append({"id": size.id, "name": size.name})

        for product_color_raw in product_colors:
            product_color: ProductColor = product_color_raw[0]

            color = await session.get(Color, product_color.color_id)

            colors.append(
                {"id": color.id, "name": color.name, "hex_code": color.hex_code}
            )

        result.append(
            {
                "id": product.id,
                "name": product.name,
                "rating": product.rating,
                "price": product.price,
                "sale": product.sale,
                "description": product.description,
                "category_id": product.category_id,
                "photo": await photo_search("product", product.id, session),
                "sizes": sizes,
                "colors": colors,
            }
        )

    return result


@product_router.post("/add")
async def product_add(
    request: Request,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        name = data["name"]
        price = data["price"]
        description = data["description"]
        category_id = data["category_id"]
        size_ids = data["size_ids"]
        color_ids = data["color_ids"]

    except:
        raise HTTPException(400, "Некорректный запрос")

    log = []

    size_ids = [int(x) for x in size_ids.split(",")]
    color_ids = [int(x) for x in color_ids.split(",")]

    category = await session.get(Category, category_id)

    if category == None:
        raise HTTPException(400, "Нет такой категории")

    stmt = (
        select(Product)
        .where(Product.name == name)
        .where(Product.category_id == category_id)
    )

    product_rep = (await session.execute(stmt)).first()

    if product_rep != None:
        raise HTTPException(400, "Такой товар уже существует")

    product_ins = {
        "name": name,
        "rating": 5,
        "price": price,
        "sale": 0,
        "description": description,
        "category_id": category_id,
    }

    await session.execute(insert(Product).values(product_ins))
    await session.commit()

    product_id = (await session.execute(stmt)).first()[0].id

    for size_id in size_ids:
        size = await session.get(Size, size_id)

        if size == None:
            log.append(f"Размер с id {size_id} не найден")

        product_size_ins = {"size_id": size_id, "product_id": product_id}

        await session.execute(insert(ProductSize).values(product_size_ins))
        await session.commit()

    for color_id in color_ids:
        color = await session.get(Color, color_id)

        if color == None:
            log.append(f"Цвет с id {color_id} не найден")

        product_color_ins = {"color_id": color_id, "product_id": product_id}

        await session.execute(insert(ProductColor).values(product_color_ins))
        await session.commit()

    return {"detail": "Товар успешно добавлен", "log": log}


@product_router.post("/delete")
async def product_delete(
    product_id: int,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    await session.execute(
        delete(ProductSize).where(ProductSize.product_id == product_id)
    )
    await session.execute(
        delete(ProductColor).where(ProductColor.product_id == product_id)
    )
    await session.execute(delete(Product).where(Product.id == product_id))
    await session.commit()

    return {"detail": "Товар успешно удален"}
