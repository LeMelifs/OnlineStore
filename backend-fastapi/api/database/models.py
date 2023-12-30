import enum

from database.database import base
from sqlalchemy import (
    TEXT,
    TIMESTAMP,
    Boolean,
    Column,
    Enum,
    ForeignKey,
    Integer,
    String,
)


class UserTypes(enum.Enum):
    admin = "admin"
    regular_user = "regular_user"


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


class Photo(base):
    __tablename__ = "photo"

    id = Column(Integer, primary_key=True)

    obj = Column(TEXT)
    obj_id = Column(Integer)

    path = Column(TEXT)
    time = Column(TIMESTAMP)


class ChangePasswordCode(base):
    __tablename__ = "change_pass_code_storage"

    id = Column(Integer, primary_key=True)

    email = Column(TEXT)
    code = Column(TEXT)
    exp_date = Column(TIMESTAMP)
