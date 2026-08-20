# Project 01 — Build a Self-Managed Kubernetes Cluster and Deploy App 02

## Objective

Build a three-node kubeadm cluster on EC2, validate cluster networking, then deploy the Python Flask API application from `03-Applications/App-02-Python-Flask-API`.

## Architecture

```text
EC2 Control Plane + 2 EC2 Workers
        |
        +-- containerd
        +-- Kubernetes 1.36
        +-- Calico CNI
        |
        v
namespace: flask-api
Deployment (2+ Pods)
Service (ClusterIP)
HPA + PDB
```

## Step 1 — Build Cluster

Follow every document in:

```text
02-Cluster-Setup/02-Kubeadm-EC2-OnPrem-Style/
```

Pass gate:

```bash
kubectl get nodes
kubectl get pods -A
kubectl get --raw='/readyz?verbose'
```

All nodes must be Ready.

## Step 2 — Build and Push Application

```bash
cd 03-Applications/App-02-Python-Flask-API
docker build -t <REGISTRY_USER>/k8s-flask-api:v1 .
docker push <REGISTRY_USER>/k8s-flask-api:v1
```

Replace the image placeholder in the Kubernetes Deployment.

## Step 3 — Deploy

```bash
kubectl apply -f kubernetes/
kubectl get deploy,pods,svc,hpa,pdb -n flask-api
```

## Step 4 — Validate

```bash
kubectl port-forward -n flask-api svc/flask-api 5000:80
curl http://localhost:5000/health
curl http://localhost:5000/api/info
```

## Step 5 — Simulate Failure

```bash
kubectl get pods -n flask-api
kubectl delete pod <one-pod> -n flask-api
kubectl get pods -n flask-api -w
```

Explain why the Pod returns without manually recreating it.

## Step 6 — Rollout and Rollback

Build `v2`, change the output/version, push it, then:

```bash
kubectl set image deployment/flask-api api=<REGISTRY_USER>/k8s-flask-api:v2 -n flask-api
kubectl rollout status deployment/flask-api -n flask-api
kubectl rollout history deployment/flask-api -n flask-api
kubectl rollout undo deployment/flask-api -n flask-api
```

## Final Evidence

Capture:

```bash
kubectl get nodes -o wide
kubectl get all -n flask-api
kubectl get hpa,pdb -n flask-api
kubectl get events -n flask-api --sort-by=.lastTimestamp
```
