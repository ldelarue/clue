# Clue

My personal Python application template for my work. 🔍  
It helps me to remember how to bootstrap a common Python project such as a Python library, a *Command Line Interface* (CLI), or a *REST API* using [FastAPI](https://fastapi.tiangolo.com/) framework.

> Clue left.  
> Unintended evidence.

## Setup ⚙️

1. This project uses [`mise`](https://mise.jdx.dev/) as tool manager.
Make sure to [install the binary](https://mise.jdx.dev/getting-started.html) in your Linux/MacOS system.

    ```bash
    mise install
    ```

2. This project uses [`uv`](https://docs.astral.sh/uv/) as Python project manager.

    ```bash
    uv sync
    ```

3. Configure your IDE and/or your shell prompt to use the dedicated Python virtual environement.

    ```bash
    source .venv/bin/activate
    ```

4. Install developer tools.

    ```bash
    uv tool install ruff
    uv tool install mkdocs --with mkdocs-material
    ```

5. Consider to install [Docker](https://docs.docker.com/engine/install/).

6. This project uses [`make`](https://www.gnu.org/software/make/) to improve developer experience.
    ```bash
    make help
    ```

## Code workflow ✨

This project uses `mypy` and `ruff` to check type consitency, format and lint Python files.

```bash
uv run mypy .
uvx ruff format
uvx ruff check --fix . 
``` 

## Tests 🫗

This project uses `pytest`, and all test scripts are located in the [`tests`](/tests/) folder.

```bash
uv run pytest .
```

## Run locally ⚡

### API using a Docker container 🐳

```bash
docker build -t clue:local .
docker run clue:local
```

Or alternatively using `make`:

```bash
make image
```

### CLI mode

```bash
uv run cli_runner_writer.py -t text!
```

### API mode

```bash
uv run api_runner_printer.py
```

Or alternatively using Docker after you built the image.

```bash
docker run -p 80:5000 clue:local
```

## User documentation 📑

This project use [`mkdocs`](https://www.mkdocs.org/) for its documentation.

```bash
uvx mkdocs serve
```

Static files are generated in `/docs-dist` folder using the following command.

```bash
uvx mkdocs build
```

## Contribution 🚀
Your contribution would be (obviously) welcomed!

- Please, read the dedicated [CONTRIBUTING.md](/CONTRIBUTING.md) page.
- Consider to follow [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specification and [angular convention](https://github.com/conventional-changelog/commitlint/tree/master/%40commitlint/config-conventional) in order to write your commit messages correctly.
