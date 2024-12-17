from fastapi import APIRouter
from src.ui.adapter import InputAdapter
from src.ui.fastapi.models import Request


def make_router(input_adapter: InputAdapter) -> APIRouter:
    router = APIRouter()

    @router.get("/")
    async def root():
        return {"message": "Hello World"}

    @router.post("/write")
    async def write(req: Request):
        input_adapter.write(req.text)
        return req

    return router
