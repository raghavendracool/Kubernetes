# Module 04 — Kubernetes YAML and API Objects: Hands-On Lab

## Objective
Generate, inspect, validate, diff and apply declarative YAML.

```bash
mkdir -p /tmp/yaml-lab && cd /tmp/yaml-lab
kubectl create namespace yaml-lab --dry-run=client -o yaml > namespace.yaml
kubectl create deployment web --image=nginx:alpine -n yaml-lab --dry-run=client -o yaml > deployment.yaml
```

Read the files and find `apiVersion`, `kind`, `metadata`, `spec`, selector and Pod-template labels.

```bash
kubectl apply --dry-run=server -f namespace.yaml
kubectl apply -f namespace.yaml
kubectl apply --dry-run=server -f deployment.yaml
kubectl diff -f deployment.yaml || true
kubectl apply -f deployment.yaml
kubectl get deployment web -n yaml-lab -o yaml
```

Change replicas from 1 to 3 in YAML, run `kubectl diff`, then apply.

```bash
kubectl get deploy,pods -n yaml-lab
kubectl delete namespace yaml-lab
```
