import enum

from database.database import base
from sqlalchemy import (
    TEXT,
    TIMESTAMP,
    Boolean,
    Column,
    Enum,
    Float,
    ForeignKey,
    Integer,
    String,
)


class UserTypes(enum.Enum):
    admin = "admin"
    regular_user = "regular_user"


class OrderStatuses(enum.Enum):
    cancelled = "cancelled"
    pending = "pending"
    delivery = "delivery"
    done = "done"
    refund = "refund"


class City(base):
    __tablename__ = "city"

    id = Column(Integer, primary_key=True)
    name = Column(TEXT, default="Vladivostok")


class User(base):
    __tablename__ = "client"

    id = Column(Integer, primary_key=True)

    username = Column(TEXT)

    first_name = Column(TEXT)

    email = Column(TEXT)
    phone_number = Column(TEXT)

    password = Column(TEXT)
    type = Column(Enum(UserTypes), default="regular_user")

    gender = Column(String(1))

    city = Column(ForeignKey(City.id))
    register_date = Column(TIMESTAMP)

    active = Column(Boolean, default=True)


class RefreshTokenStorage(base):
    __tablename__ = "refresh_token_storage"

    id = Column(Integer, primary_key=True)

    refresh_token = Column(TEXT)
    expired = Column(TIMESTAMP)


class ContractStorage(base):
    __tablename__ = "contract_storage"

    id = Column(Integer, primary_key=True)

    paid = Column(Boolean)


class ChangePasswordCode(base):
    __tablename__ = "change_pass_code_storage"

    id = Column(Integer, primary_key=True)

    email = Column(TEXT)
    code = Column(TEXT)
    exp_date = Column(TIMESTAMP)


class Photo(base):
    __tablename__ = "photo"

    id = Column(Integer, primary_key=True)

    obj = Column(TEXT)
    obj_id = Column(Integer)

    path = Column(TEXT)
    time = Column(TIMESTAMP)


class Color(base):
    __tablename__ = "color"

    id = Column(Integer, primary_key=True)

    name = Column(TEXT)
    hex_code = Column(TEXT)


class Size(base):
    __tablename__ = "size"

    id = Column(Integer, primary_key=True)
    name = Column(TEXT)


class Category(base):
    __tablename__ = "category"

    id = Column(Integer, primary_key=True)
    name = Column(TEXT)


class Product(base):
    __tablename__ = "product"

    id = Column(Integer, primary_key=True)

    name = Column(TEXT)
    rating = Column(Float)

    price = Column(Integer)
    sale = Column(Integer, default="0")

    description = Column(TEXT)
    short_description = Column(String(70))

    category_id = Column(ForeignKey(Category.id))

    active = Column(Boolean, default=True)


class ProductSize(base):
    __tablename__ = "product_size"

    id = Column(Integer, primary_key=True)

    product_id = Column(ForeignKey(Product.id))
    size_id = Column(ForeignKey(Size.id))


class ProductColor(base):
    __tablename__ = "product_color"

    id = Column(Integer, primary_key=True)

    product_id = Column(ForeignKey(Product.id))
    color_id = Column(ForeignKey(Color.id))


class Bin(base):
    __tablename__ = "bin"

    id = Column(Integer, primary_key=True)

    user_id = Column(ForeignKey(User.id))
    product_id = Column(ForeignKey(Product.id))

    size_id = Column(ForeignKey(Size.id))
    color_id = Column(ForeignKey(Color.id))


class PickPoint(base):
    __tablename__ = "pickpoint"

    id = Column(Integer, primary_key=True)

    name = Column(TEXT)
    city_id = Column(ForeignKey(City.id))


class Order(base):
    __tablename__ = "order"

    id = Column(Integer, primary_key=True)

    num = Column(TEXT)
    sum = Column(Integer)

    user_id = Column(ForeignKey(User.id))

    create_time = Column(TIMESTAMP)
    close_time = Column(TIMESTAMP)

    pickpoint_id = Column(ForeignKey(PickPoint.id))

    status = Column(Enum(OrderStatuses), default="pending")


class OrderProduct(base):
    __tablename__ = "order_product"

    id = Column(Integer, primary_key=True)

    num = Column(TEXT)

    product_id = Column(ForeignKey(Product.id))
    size_id = Column(ForeignKey(Size.id))
    color_id = Column(ForeignKey(Color.id))
