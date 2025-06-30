# Use official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirement file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy your application code
COPY main.py .

# Cloud Run expects the container to listen on PORT
ENV PORT=8080

# Start the Flask app using Python (no gunicorn)
CMD ["python", "main.py"]
