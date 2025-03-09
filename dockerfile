# Use a lightweight Python base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies including build-essential for gcc
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    ffmpeg \
    zlib1g-dev \
    libjpeg62-turbo-dev \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install Poetry and configure pip with a longer timeout and a mirror
RUN pip install --upgrade pip && \
    pip config set global.timeout 300 && \
    pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/ && \
    pip install poetry

# Copy project files
COPY pyproject.toml ./

# Install dependencies with retries
RUN poetry config virtualenvs.create false && \
    for i in 1 2 3; do poetry install --no-root && break || sleep 10; done

# Copy the entire application
COPY . .

# Set the default command to run the FastAPI app
CMD ["poetry", "run", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]