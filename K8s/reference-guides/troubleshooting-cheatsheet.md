# Troubleshooting Cheat Sheet

```bash
kubectl get pods -n <ns> -o wide
kubectl describe pod <pod> -n <ns>
kubectl get events -n <ns> --sort-by=.lastTimestamp
kubectl logs <pod> -n <ns>
kubectl logs <pod> -n <ns> --previous
```

| Status | First Area |
|---|---|
| Pending | scheduler/PVC/resources |
| ImagePullBackOff | image/registry/auth |
| CrashLoopBackOff | process/logs/config |
| Running 0/1 Ready | readiness |
| OOMKilled | memory |
| Forbidden | RBAC |
| Service no response | selector/endpoints/ports |
| PVC Pending | StorageClass/CSI |
