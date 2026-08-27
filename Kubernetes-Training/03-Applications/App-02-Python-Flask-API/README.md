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

## Docker Install (Ubuntu)

Use this once on the node where you want to build images.

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker
docker version
```

If `newgrp docker` does not refresh group membership in your shell, log out and log back in, then run `docker version` again.

## Docker

```bash
docker build -t <REGISTRY_USER>/k8s-flask-api:v1 .
docker run --rm -p 5000:5000 -e APP_ENV=docker <REGISTRY_USER>/k8s-flask-api:v1
curl http://localhost:5000/api/info
```

Push the image and replace `<REGISTRY_USER>` in the Deployment manifest.

## No Registry (EC2 Only)

Use this path when you do not want Docker Hub or any external registry.

1. Build image on control-plane node.

```bash
cd 03-Applications/App-02-Python-Flask-API
docker build -t k8s-flask-api:v1 .
docker save k8s-flask-api:v1 -o k8s-flask-api-v1.tar
```

2. Copy image tar to worker nodes.

```bash
scp k8s-flask-api-v1.tar ubuntu@k8s-worker-01:/tmp/
scp k8s-flask-api-v1.tar ubuntu@k8s-worker-02:/tmp/
```

3. Import image into containerd on every node (control-plane and workers).

```bash
sudo ctr -n k8s.io images import k8s-flask-api-v1.tar
sudo ctr -n k8s.io images ls | grep k8s-flask-api
```

Run the same import command on each worker using `/tmp/k8s-flask-api-v1.tar`.

4. Update Deployment image and pull policy in `kubernetes/02-deployment.yaml`.

- Set image to `k8s-flask-api:v1`
- Add `imagePullPolicy: IfNotPresent` under the container

5. Deploy and validate.

```bash
kubectl apply -f kubernetes/
kubectl get pods -n flask-api -o wide
kubectl get svc -n flask-api
kubectl get hpa -n flask-api
```

## Kubernetes Deploy

```bash
kubectl apply -f kubernetes/
kubectl get all -n flask-api
kubectl get hpa -n flask-api
kubectl port-forward -n flask-api svc/flask-api 5000:80
curl http://localhost:5000/api/info
```

If you run `port-forward` on EC2, test from the same EC2 shell. From your laptop, use EC2 public IP and service/node access methods instead of `127.0.0.1`.

## Rollout Demo

```bash
kubectl set image deployment/flask-api api=<REGISTRY_USER>/k8s-flask-api:v2 -n flask-api
kubectl rollout status deployment/flask-api -n flask-api
kubectl rollout history deployment/flask-api -n flask-api
kubectl rollout undo deployment/flask-api -n flask-api
```
