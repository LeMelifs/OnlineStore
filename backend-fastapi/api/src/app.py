import ujson
from fastapi import FastAPI
from src.v1.api import router

app = FastAPI()


@app.on_event("startup")
async def startup_event():
    app.json_encoder = ujson


app.include_router(router, prefix="/api/v1")
