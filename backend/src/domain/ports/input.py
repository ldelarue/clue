from abc import ABC, abstractmethod
from dataclasses import dataclass

from src.domain.ports.output import OutputPort


@dataclass
class InputPort(ABC):
    output: OutputPort

    @abstractmethod
    def send(self, text: str) -> None:
        """Send text to the output

        :param text: Text to send
        """
