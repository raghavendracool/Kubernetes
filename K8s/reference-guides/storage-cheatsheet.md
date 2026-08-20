# Storage Cheat Sheet

```text
Pod → PVC → StorageClass/PV → CSI → Real Storage
```

```bash
kubectl get pvc -A
kubectl describe pvc <pvc> -n <ns>
kubectl get pv
kubectl get storageclass
kubectl get csidriver
```
