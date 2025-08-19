FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY app/requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY app /app

# Expose port
EXPOSE 8080

# Use gunicorn for production serving
CMD ["gunicorn", "-b", "0.0.0.0:8080", "app:app"]
