# App 03 — Three-Tier Store Demo

A separate end-to-end application used only after the Kubernetes fundamentals are complete.

```text
Browser
  |
  v
Frontend Nginx
  |
  | /api/*
  v
Python Flask Backend
  |
  v
PostgreSQL StatefulSet + PVC   (training cluster)
```

The Kubernetes manifests require a working default dynamic StorageClass (for example EBS CSI-backed storage on EKS). For a production EKS project, replace the in-cluster PostgreSQL layer with a managed database such as Amazon RDS. The in-cluster database here exists only to teach StatefulSet/PVC/service discovery.

## Build Images

```bash
# backend
docker build -t <REGISTRY_USER>/store-api:v1 backend/
docker push <REGISTRY_USER>/store-api:v1

# frontend
docker build -t <REGISTRY_USER>/store-web:v1 frontend/
docker push <REGISTRY_USER>/store-web:v1
```

Replace `<REGISTRY_USER>` in `kubernetes/04-backend.yaml` and `kubernetes/06-frontend.yaml`.

## Deploy

```bash
kubectl apply -f kubernetes/
kubectl get all,pvc -n store
kubectl get pods -n store -w
```

Initialize/sample data is created automatically by the backend on startup.

Access:

```bash
kubectl port-forward -n store svc/store-web 8080:80
```

Open `http://localhost:8080`.

## Debug Flow

```bash
kubectl get pods -n store -o wide
kubectl get svc,endpointslice -n store
kubectl logs -n store deployment/store-api
kubectl logs -n store deployment/store-web
kubectl describe pvc -n store postgres-data-postgres-0
```

## Cleanup

```bash
kubectl delete namespace store
```
