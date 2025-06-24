from dataclasses import dataclass
from src.ui.adapter import InputAdapter
from fastapi import FastAPI
from src.ui.fastapi.routers import endpoints


@dataclass
class API(InputAdapter):
    def __post_init__(self):
        self.app = FastAPI(routes=endpoints.make_router(self).routes)
