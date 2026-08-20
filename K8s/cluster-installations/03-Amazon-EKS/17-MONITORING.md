# 17 — Monitoring

Distinguish:
- events;
- container logs;
- node metrics;
- Pod metrics;
- application metrics;
- control-plane logs;
- AWS infrastructure metrics.

Minimum:

```bash
kubectl get events -A --sort-by=.lastTimestamp
kubectl top nodes
kubectl top pods -A
kubectl logs <pod> -n <namespace>
```
