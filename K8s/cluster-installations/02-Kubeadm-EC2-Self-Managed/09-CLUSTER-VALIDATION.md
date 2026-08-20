# 09 — Cluster Validation

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl cluster-info
kubectl get --raw='/readyz?verbose'
kubectl get events -A --sort-by=.lastTimestamp
```

On every node:

```bash
sudo systemctl status containerd --no-pager
sudo systemctl status kubelet --no-pager
```
