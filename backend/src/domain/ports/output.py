from abc import ABC
from abc import abstractmethod


class OutputPort(ABC):
    @abstractmethod
    def write(self, text: str) -> None:
        """Write text to the output

        :param text: Text to write
        """
