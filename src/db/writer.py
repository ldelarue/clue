from pathlib import Path
from dataclasses import dataclass
from src.domain.ports.output import OutputPort


@dataclass
class Writer(OutputPort):
    """Writer class for writing things in a file"""

    file_path: str

    def write(self, text):
        """Write text to the output"""

        Path(self.file_path).parent.mkdir(parents=True, exist_ok=True)
        with open(self.file_path, "w") as f:
            f.write(text)
