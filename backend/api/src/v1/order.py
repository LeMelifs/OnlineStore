from random import randint

from database.database import get_session
from database.models import (
    Bin,
    Category,
    Color,
    Order,
    OrderProduct,
    PickPoint,
    Product,
    Size,
)
from fastapi import APIRouter, Depends, HTTPException, Request
from fastapi.responses import FileResponse
from sqlalchemy import delete, desc, func, insert, select, update
from sqlalchemy.ext.asyncio import AsyncSession
from src.utils import photo_search, time
from src.v1.auth import admin_required, login_required

order_router = APIRouter()


@order_router.get("/view")
async def order_view(
    user=Depends(login_required), session: AsyncSession = Depends(get_session)
):
    result = []

    orders_raw = (
        await session.execute(
            select(Order)
            .where(Order.user_id == user.id)
            .order_by(desc(Order.create_time))
        )
    ).all()

    for order_raw in orders_raw:
        order: Order = order_raw[0]

        count = 0
        products_local = []

        products = (
            await session.execute(
                select(OrderProduct).where(OrderProduct.num == order.num)
            )
        ).all()

        for product_bin_raw in products:
            product_bin: OrderProduct = product_bin_raw[0]

            product = await session.get(Product, product_bin.product_id)
            size = await session.get(Size, product_bin.size_id)
            color = await session.get(Color, product_bin.color_id)

            count += 1

            product.photo = await photo_search("product", product.id, session)
            product.size = {"id": size.id, "name": size.name}
            product.color = {
                "id": color.id,
                "name": color.name,
                "hex_code": color.hex_code,
            }

            products_local.append(product)

        result.append(
            {
                "num": order.num,
                "create_time": order.create_time,
                "close_time": order.close_time,
                "status": order.status,
                "pickpoint": (await session.get(PickPoint, order.pickpoint_id)).name,
                "products": products_local,
            }
        )

    return result


@order_router.post("/add")
async def order_add(
    request: Request,
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    try:
        data = await request.json()

        pickpoint_id = data["pickpoint_id"]
        product_ids = data["product_ids"]

    except:
        raise HTTPException(400, "Некорректный запрос")

    pickpoint = await session.get(PickPoint, pickpoint_id)

    if pickpoint == None:
        raise HTTPException(400, "Такой точки выдачи не существует")

    sum = 0

    now = time()

    if product_ids != "":
        products = [
            (
                await session.execute(
                    select(Bin)
                    .where(Bin.user_id == user.id)
                    .where(Bin.product_id == int(x))
                )
            ).first()
            for x in product_ids.split(",")
        ]
    else:
        products = (
            await session.execute(select(Bin).where(Bin.user_id == user.id))
        ).all()

    codes = [
        x._mapping["distinct"]
        for x in (await session.execute(select(func.distinct(Order.num)))).all()
    ]

    alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

    code = "".join([alphabet[randint(0, 25)] for _ in range(6)])

    while code in codes:
        code = "".join([alphabet[randint(0, 25)] for _ in range(6)])

    for product_bin_raw in products:
        product_bin: Bin = product_bin_raw[0]

        product = await session.get(Product, product_bin.product_id)

        sum += product.price

        temp_ins = {
            "num": code,
            "product_id": product_bin.product_id,
            "size_id": product_bin.size_id,
            "color_id": product_bin.color_id,
        }

        await session.execute(insert(OrderProduct).values(temp_ins))
        await session.execute(delete(Bin).where(Bin.id == product_bin.id))
        await session.commit()

    order_ins = {
        "num": code,
        "user_id": user.id,
        "sum": sum,
        "create_time": now,
        "pickpoint_id": pickpoint_id,
    }

    await session.execute(insert(Order).values(order_ins))
    await session.commit()

    return {"detail": "Заказ успешно сформирован"}


@order_router.post("/activate")
async def order_activate(
    order_num: str,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    order = (await session.execute(select(Order).where(Order.num == order_num))).first()

    if order == None:
        raise HTTPException(400, "Такой заказ не найден")

    await session.execute(
        update(Order).where(Order.num == order_num).values(status="delivery")
    )
    await session.commit()

    return {"detail": "Заказ подтвержден"}


@order_router.post("/done")
async def order_done(
    order_num: str,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    order = (await session.execute(select(Order).where(Order.num == order_num))).first()

    if order == None:
        raise HTTPException(400, "Такой заказ не найден")

    await session.execute(
        update(Order).where(Order.num == order_num).values(status="done")
    )
    await session.commit()

    return {"detail": "Заказ получен"}


@order_router.post("/refund")
async def order_refund(
    order_num: str,
    user=Depends(admin_required),
    session: AsyncSession = Depends(get_session),
):
    order = (await session.execute(select(Order).where(Order.num == order_num))).first()

    if order == None:
        raise HTTPException(400, "Такой заказ не найден")

    await session.execute(
        update(Order).where(Order.num == order_num).values(status="refund")
    )
    await session.commit()

    return {"detail": "Заказ возвращен"}


@order_router.post("/cancel")
async def order_cancel(
    order_num: str,
    user=Depends(login_required),
    session: AsyncSession = Depends(get_session),
):
    order = (await session.execute(select(Order).where(Order.num == order_num))).first()

    if order == None:
        raise HTTPException(400, "Такой заказ не найден")

    await session.execute(
        update(Order).where(Order.num == order_num).values(status="cancelled")
    )
    await session.commit()

    return {"detail": "Заказ отменен"}
