from fastapi import FastAPI
import uvicorn
from src.ui.api import API
from src.db.printer import Printer
from src.domain.runner import Runner


def main() -> FastAPI:
    writer = Printer()
    runner = Runner(writer)
    api = API(runner)

    return api.app


app = main()

if __name__ == "__main__":  # pragma: no cover
    uvicorn.run("api_runner_printer:app", host="0.0.0.0", port=5000, log_level="info")
