#!/bin/bash
apt-get update && apt-get install -y libgl1-mesa-glx
exec uvicorn app:app --host 0.0.0.0 --port $PORT
