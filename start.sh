#!/bin/bash

# Install system dependencies required for OpenCV
apt-get update && apt-get install -y libgl1-mesa-glx libglib2.0-0

# Run the FastAPI server
exec uvicorn app:app --host 0.0.0.0 --port 8000
