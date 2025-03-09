# Use a lightweight Python base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender-dev \
    ffmpeg || \
    (apt-get update && apt-get install -y \
    mesa-utils \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libgl1 \
    libxrender1 \
    libsm6 \
    libxext6 \
    ffmpeg) && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY pyproject.toml ./
RUN pip install poetry && poetry install --no-root

# Copy the entire application
COPY . .

# Set the default command to run the FastAPI app
CMD ["poetry", "run", "uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
