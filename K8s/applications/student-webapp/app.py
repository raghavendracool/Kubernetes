from flask import Flask
import os
import socket

app = Flask(__name__)

@app.get("/")
def home():
    return {
        "message": os.getenv("APP_MESSAGE", "Hello from Kubernetes"),
        "environment": os.getenv("APP_ENV", "local"),
        "hostname": socket.gethostname()
    }

@app.get("/healthz")
def health():
    return {"status": "ok"}, 200

@app.get("/readyz")
def ready():
    return {"status": "ready"}, 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
