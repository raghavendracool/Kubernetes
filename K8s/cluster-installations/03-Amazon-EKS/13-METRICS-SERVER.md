# 13 — Metrics Server

Install using current official release/Helm instructions.

Validate:

```bash
kubectl get deployment -n kube-system metrics-server
kubectl top nodes
kubectl top pods -A
```
