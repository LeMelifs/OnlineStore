from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from src.v1.api import router

app = FastAPI()

origins = [
    "http://localhost:8005",
    "https://onlinestore.poslam.ru",
    "http://localhost:9000",
    "http://127.0.0.1:9000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(router, prefix="/api/v1")
