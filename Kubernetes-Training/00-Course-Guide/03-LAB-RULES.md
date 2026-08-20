# Lab Rules

1. Use a dedicated learning AWS account or sandbox where possible.
2. Never paste production credentials into YAML or Git.
3. Use IAM roles / short-lived credentials instead of long-lived access keys.
4. Tag all AWS lab resources.
5. Run cleanup commands after every lab.
6. Before `kubectl apply`, inspect the YAML.
7. After every change, verify desired state and actual state.
8. Use `kubectl describe` and `kubectl logs` before randomly deleting pods.

## Standard Validation Pattern

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp
kubectl cluster-info
```
