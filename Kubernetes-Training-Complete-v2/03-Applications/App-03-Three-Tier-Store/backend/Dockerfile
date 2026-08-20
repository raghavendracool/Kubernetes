FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py .
RUN useradd --create-home --uid 10001 appuser
USER appuser
EXPOSE 5000
CMD ["gunicorn","--bind","0.0.0.0:5000","--workers","1","app:app"]
