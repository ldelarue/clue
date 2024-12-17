from src.ui.cli import CLI
from src.db.writer import Writer
from src.domain.runner import Runner


def main(file_path: str = "sbx/data.txt"):
    writer = Writer(file_path)
    runner = Runner(writer)
    cli = CLI(runner)
    cli.exec()


if __name__ == "__main__":  # pragma: no cover
    main()
