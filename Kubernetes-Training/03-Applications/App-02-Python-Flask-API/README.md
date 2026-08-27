# App 02 - Python Flask API

This app is now configured for a full EC2 kubeadm demo without external registry.

## Two Demo Paths For Students

Use both paths in class so students understand the difference between container runtime and Kubernetes orchestration.

- Path A: Run app as a standalone Docker container.
- Path B: Run the same app as Kubernetes Pods behind a Service.

## Current Behavior

- / serves a styled DevOps Training Portal HTML page
- /health returns liveness and readiness response
- /api/info returns hostname, environment, and version

## Manifest State (Already Aligned)

- Deployment image: k8s-flask-api:v1
- imagePullPolicy: IfNotPresent
- Pod securityContext includes runAsNonRoot + UID/GID 10001
- Service type: NodePort
- Service port mapping: 80 -> 5000
- NodePort: 30080

## Path A - Docker Container Demo (No Kubernetes)

Run on control-plane node.

### A1) Install Docker (once)

```bash
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker
docker version
```

### A2) Build and run container

```bash
cd ~/Kubernetes/Kubernetes-Training/03-Applications/App-02-Python-Flask-API

docker build -t k8s-flask-api:v1 .
docker run --rm -p 5000:5000 -e APP_ENV=docker -e APP_VERSION=v1 k8s-flask-api:v1
```

Keep this terminal running, then from another terminal on same EC2:

```bash
curl http://127.0.0.1:5000/health
curl http://127.0.0.1:5000/api/info
```

Optional browser test from laptop:

- Add EC2 Security Group inbound TCP 5000.
- Open http://<CONTROL_PLANE_PUBLIC_IP>:5000/

Stop demo container with Ctrl+C.

## Path B - Kubernetes Pods Demo (EC2 Only, No Registry)

Run all commands from control-plane node unless noted.

### B1) Local Prerequisites

```bash
cd ~/Kubernetes/Kubernetes-Training/03-Applications/App-02-Python-Flask-API

sudo apt update
sudo apt install -y python3-venv python3-pip python-is-python3 docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
newgrp docker
docker version
```

### B2) Build App Image and Export Tar

```bash
cd ~/Kubernetes/Kubernetes-Training/03-Applications/App-02-Python-Flask-API

docker build -t k8s-flask-api:v1 .
docker save k8s-flask-api:v1 -o k8s-flask-api-v1.tar
```

### B3) Copy Image Tar to Workers Using k8s.pem

If key is already on control-plane:

```bash
chmod 400 /home/ubuntu/k8s.pem

scp -i /home/ubuntu/k8s.pem k8s-flask-api-v1.tar ubuntu@172.31.45.109:/tmp/
scp -i /home/ubuntu/k8s.pem k8s-flask-api-v1.tar ubuntu@172.31.37.3:/tmp/
```

If key is only on laptop, copy it once to control-plane:

```bash
scp -i "C:/Users/<USER>/Downloads/k8s.pem" "C:/Users/<USER>/Downloads/k8s.pem" ubuntu@<CONTROL_PLANE_PUBLIC_IP>:/home/ubuntu/k8s.pem
chmod 400 /home/ubuntu/k8s.pem
```

### B4) Import Image Into containerd on All Nodes

Workers:

```bash
ssh -i /home/ubuntu/k8s.pem ubuntu@172.31.45.109 "sudo ctr -n k8s.io images import /tmp/k8s-flask-api-v1.tar"
ssh -i /home/ubuntu/k8s.pem ubuntu@172.31.37.3 "sudo ctr -n k8s.io images import /tmp/k8s-flask-api-v1.tar"
```

Control-plane:

```bash
sudo ctr -n k8s.io images import k8s-flask-api-v1.tar
sudo ctr -n k8s.io images ls | grep k8s-flask-api
```

### B5) Deploy Kubernetes Manifests

```bash
kubectl apply -f kubernetes/
kubectl rollout restart deployment/flask-api -n flask-api
kubectl rollout status deployment/flask-api -n flask-api
```

### B6) Validate Workloads

```bash
kubectl get pods -n flask-api -o wide
kubectl get svc -n flask-api
kubectl get hpa -n flask-api
kubectl get pdb -n flask-api
```

### B7) Open App in Browser (Proper App Access)

Open from laptop browser:

- http://<CONTROL_PLANE_PUBLIC_IP>:30080/
- http://<CONTROL_PLANE_PUBLIC_IP>:30080/health
- http://<CONTROL_PLANE_PUBLIC_IP>:30080/api/info

Security Group requirement:

- Allow inbound TCP 30080 on control-plane EC2 instance

### B8) Optional Port-Forward Check

```bash
kubectl port-forward -n flask-api svc/flask-api 5000:80
```

Then from second control-plane shell:

```bash
curl http://127.0.0.1:5000/health
curl http://127.0.0.1:5000/api/info
```

## Rollout Demo Without Registry

### Build v2 image locally

```bash
docker build -t k8s-flask-api:v2 .
docker save k8s-flask-api:v2 -o k8s-flask-api-v2.tar
```

### Copy and import v2 on all nodes

```bash
scp -i /home/ubuntu/k8s.pem k8s-flask-api-v2.tar ubuntu@172.31.45.109:/tmp/
scp -i /home/ubuntu/k8s.pem k8s-flask-api-v2.tar ubuntu@172.31.37.3:/tmp/

ssh -i /home/ubuntu/k8s.pem ubuntu@172.31.45.109 "sudo ctr -n k8s.io images import /tmp/k8s-flask-api-v2.tar"
ssh -i /home/ubuntu/k8s.pem ubuntu@172.31.37.3 "sudo ctr -n k8s.io images import /tmp/k8s-flask-api-v2.tar"
sudo ctr -n k8s.io images import k8s-flask-api-v2.tar
```

### Update deployment and verify rollout

```bash
kubectl set image deployment/flask-api api=k8s-flask-api:v2 -n flask-api
kubectl rollout status deployment/flask-api -n flask-api
kubectl rollout history deployment/flask-api -n flask-api
kubectl rollout undo deployment/flask-api -n flask-api
```

## Troubleshooting

- If pods show CreateContainerConfigError, verify deployment securityContext has UID/GID 10001.
- If pods show ImagePullBackOff, import image tar on the node where pod is scheduled.
- If browser cannot open NodePort, verify EC2 Security Group inbound TCP 30080.
- If SCP fails with Permission denied (publickey), check key path and chmod 400 on k8s.pem.
