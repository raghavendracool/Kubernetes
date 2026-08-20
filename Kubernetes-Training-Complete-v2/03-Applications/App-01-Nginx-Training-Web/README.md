# App 01 — Nginx Training Web

This application is intentionally simple. It is used to teach image build/push, Deployment, Service and ConfigMap without mixing application complexity into the Kubernetes concept modules.

## Build

```bash
cd 03-Applications/App-01-Nginx-Training-Web
docker build -t <REGISTRY_USER>/k8s-training-web:v1 .
docker run --rm -p 8080:80 <REGISTRY_USER>/k8s-training-web:v1
curl http://localhost:8080
```

## Push

```bash
docker login
docker push <REGISTRY_USER>/k8s-training-web:v1
```

Update the image in `kubernetes/01-deployment.yaml`.

## Deploy

```bash
kubectl apply -f kubernetes/
kubectl get deploy,pods,svc -n training-web
kubectl port-forward -n training-web svc/training-web 8080:80
```

Open `http://localhost:8080`.

## Cleanup

```bash
kubectl delete namespace training-web
```
