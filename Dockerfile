# This Dockerfile was inspired by <https://hynek.me/articles/docker-uv/>.

FROM python:3.12-slim AS python-env

FROM python-env AS build-env

SHELL ["sh", "-exc"]

COPY --from=ghcr.io/astral-sh/uv:0.5.9 /uv /usr/local/bin/uv

# - Silence uv complaining about not being able to use hard links,
# - tell uv to byte-compile packages for faster application startups,
# - prevent uv from accidentally downloading isolated Python builds,
# - and finally declare `/app` as the target for `uv sync`.
ENV UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_PYTHON_DOWNLOADS=never \
    UV_PROJECT_ENVIRONMENT=/src

COPY pyproject.toml /_lock/
COPY uv.lock /_lock/

RUN --mount=type=cache,target=/root/.cache <<EOT
cd /_lock
uv sync \
    --locked \
    --no-dev \
    --no-install-project
EOT

COPY . /src
RUN --mount=type=cache,target=/root/.cache \
    cd /src && uv sync --locked --no-dev --no-editable

##########################################################################

FROM python-env AS runtime-env

SHELL ["sh", "-exc"]
ENV PATH=/app/bin:$PATH

# Don't run your app as root.
RUN <<EOT
groupadd -r app
useradd -r -d /app -g app -N app
EOT

COPY --from=build-env --chown=app:app /src /app

USER app
WORKDIR /app

ENTRYPOINT ["python", "api_runner_printer.py"]
