import ujson
from fastapi import FastAPI
from src.v1.api import router
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

origins = [
    "http://localhost:9000",
    "http://localhost:8005",
    'https://onlinestore.poslam.ru'
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.on_event("startup")
async def startup_event():
    app.json_encoder = ujson


app.include_router(router, prefix="/api/v1")
