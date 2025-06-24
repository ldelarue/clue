from abc import ABC

from dataclasses import dataclass

from src.domain.ports.input import InputPort


@dataclass
class InputAdapter(ABC):
    input_port: InputPort

    def write(self, text: str):
        self.input_port.send(text)
