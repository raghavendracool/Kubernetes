# Ubuntu Minikube Setup

## Docker

```bash
docker --version
docker run --rm hello-world
```

## Install Minikube

```bash
curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version
```

Install kubectl using current official Kubernetes instructions, then:

```bash
kubectl version --client
```

## Start

```bash
minikube start   --driver=docker   --container-runtime=containerd   --cpus=2   --memory=4096
```

## Validate

```bash
minikube status
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -A
```

## Add-ons

```bash
minikube addons enable metrics-server
minikube addons enable ingress
minikube addons list
```
