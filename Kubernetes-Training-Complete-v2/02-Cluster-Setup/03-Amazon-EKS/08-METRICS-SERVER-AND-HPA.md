# 8. Metrics Server and HPA

## Install Metrics Server

```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

## Validate

```bash
kubectl rollout status deployment/metrics-server -n kube-system
kubectl top nodes
kubectl top pods -A
```

HPA based on CPU/memory usually needs workload resource requests so utilization percentages have a meaningful baseline.

```bash
kubectl get apiservice v1beta1.metrics.k8s.io
```
