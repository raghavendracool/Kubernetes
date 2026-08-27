# App 02 — Python Flask API

This is a small API used for Deployments, Services, ConfigMaps, probes, resources, HPA and rollout demonstrations.

## Endpoints

- `/` — application information
- `/health` — liveness/readiness endpoint
- `/api/info` — Pod/environment information

## Local Run

```bash
cd 03-Applications/App-02-Python-Flask-API

# Ubuntu/Debian prerequisites (run once)
sudo apt update
sudo apt install -y python3-venv python3-pip python-is-python3

# Create and activate virtual environment
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
python -m pip install --upgrade pip
pip install -r requirements.txt

# Run and test
APP_ENV=local python app.py
curl http://localhost:5000/health
```

If virtual environment creation fails with an `ensurepip` error, install a versioned venv package for your Python version and recreate `.venv`:

```bash
python3 --version
sudo apt install -y python3.12-venv
rm -rf .venv
python3 -m venv .venv
```

## Docker

```bash
docker build -t <REGISTRY_USER>/k8s-flask-api:v1 .
docker run --rm -p 5000:5000 -e APP_ENV=docker <REGISTRY_USER>/k8s-flask-api:v1
curl http://localhost:5000/api/info
```

Push the image and replace `<REGISTRY_USER>` in the Deployment manifest.

## Kubernetes Deploy

```bash
kubectl apply -f kubernetes/
kubectl get all -n flask-api
kubectl get hpa -n flask-api
kubectl port-forward -n flask-api svc/flask-api 5000:80
curl http://localhost:5000/api/info
```

## Rollout Demo

```bash
kubectl set image deployment/flask-api api=<REGISTRY_USER>/k8s-flask-api:v2 -n flask-api
kubectl rollout status deployment/flask-api -n flask-api
kubectl rollout history deployment/flask-api -n flask-api
kubectl rollout undo deployment/flask-api -n flask-api
```
