from src.domain.ports.input import InputPort


class Runner(InputPort):
    """Runner class for running"""

    def send(self, text: str) -> None:
        """Send text to the output

        :param text: Text to send
        """
        self.output.write(text)
