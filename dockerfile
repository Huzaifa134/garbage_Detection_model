FROM python:3.10-slim

WORKDIR /app

RUN apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0 ffmpeg

COPY pyproject.toml poetry.lock ./
RUN pip install poetry && poetry install --no-root

COPY . .

CMD ["poetry", "run", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
