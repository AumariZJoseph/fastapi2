FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
#RUN apt-get update && apt-get install -y \
   #curl \
   #gcc \
   #g++ \
   #&& rm -rf /var/lib/apt/lists/*

# Copy requirements first
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Pre-download the embedding model
#RUN python -c "from sentence_transformers import SentenceTransformer; SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')"

# Copy application code
COPY . .

# Expose port
EXPOSE 8000

# Health check
#HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
   #CMD curl -f http://localhost:8000/health || exit 1

# Start the application
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
