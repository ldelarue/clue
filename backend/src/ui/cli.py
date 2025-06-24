import argparse

from dataclasses import dataclass
from src.ui.adapter import InputAdapter

import sys


@dataclass
class CLI(InputAdapter):
    @staticmethod
    def get_text_argument(args: list[str]) -> argparse.Namespace:
        parser = argparse.ArgumentParser(description="CLI example.")
        parser.add_argument("-t", "--text", help="Text to write.", required=True)
        return parser.parse_args(args)

    def exec(self):
        text: str = self.get_text_argument(sys.argv[1:]).text
        self.write(text)
