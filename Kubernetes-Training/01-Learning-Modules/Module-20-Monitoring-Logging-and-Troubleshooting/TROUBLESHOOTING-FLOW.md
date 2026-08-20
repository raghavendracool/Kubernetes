# Kubernetes Troubleshooting Decision Flow

```text
Problem reported
   |
   +--> Is the cluster reachable? --> kubectl cluster-info / get nodes
   |
   +--> Is the resource present? --> kubectl get ... -A
   |
   +--> Pod state?
           |
           +--> Pending --> describe pod --> scheduler/PVC/taint/resources
           +--> ImagePullBackOff --> events --> image/registry/secret
           +--> CrashLoopBackOff --> logs + logs --previous --> app/config/probe
           +--> Running but unavailable --> readiness/service/endpoints
           +--> Running but no network --> DNS/service/CNI/network policy
   |
   +--> Node issue --> describe node + kubelet/containerd/system logs
```

## Minimum incident evidence

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp
kubectl describe pod <pod> -n <ns>
kubectl logs <pod> -n <ns> --all-containers --tail=200
```
