# Module 10 — Probes, Resources and QoS: Hands-On Lab

## Objective
Observe readiness, requests/limits and a probe failure.

```bash
kubectl create namespace health-lab
kubectl apply -n health-lab -f examples/probes-resources.yaml
kubectl get pod health-demo -n health-lab -w
kubectl describe pod health-demo -n health-lab
kubectl get pod health-demo -n health-lab -o jsonpath='{.status.qosClass}'; echo
```

If Metrics Server exists:

```bash
kubectl top pod health-demo -n health-lab
```

Break readiness:

```bash
kubectl patch pod health-demo -n health-lab --type='json' \
  -p='[{"op":"replace","path":"/spec/containers/0/readinessProbe/httpGet/path","value":"/does-not-exist"}]' || true
```

Because many Pod spec fields are immutable, the patch may be rejected. Explain why production probe changes are normally done through the owning Deployment and Pod recreation.

```bash
kubectl delete namespace health-lab
```
