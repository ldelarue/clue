from src.domain.ports.output import OutputPort


class Printer(OutputPort):
    """Printer class for printing"""

    def write(self, text):
        """Print text to the output"""
        print(text)
