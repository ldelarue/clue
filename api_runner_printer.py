from typing_extensions import Annotated
from fastapi import FastAPI
import uvicorn
from src.ui.api import API
from src.db.printer import Printer
from src.domain.runner import Runner
from fastapi.middleware.cors import CORSMiddleware
from annotated_types import Gt
from pydantic_settings import BaseSettings



def main() -> FastAPI:
    writer = Printer()
    runner = Runner(writer)
    api = API(runner)

    return api.app

app = main()


class Settings(BaseSettings):
    FRONTEND_URL: str = "http://localhost"
    FRONTEND_PORT: Annotated[int, Gt(1024)] = 8081
    
    DEBUG: bool = False

    class Config:
        env_file = ".env"


origins = [
    f"{Settings().FRONTEND_URL}:{Settings().FRONTEND_PORT}",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

if __name__ == "__main__":  # pragma: no cover
    uvicorn.run("api_runner_printer:app", host="0.0.0.0", port=8080, log_level="info")
