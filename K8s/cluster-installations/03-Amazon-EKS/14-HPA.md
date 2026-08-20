# 14 — HPA on EKS

```bash
kubectl apply -f learning-modules/Module-17-Autoscaling-and-Availability/stage/
kubectl get hpa -n student-app
```

Remember:

```text
HPA scales Pods.
It does not create EC2 worker nodes.
```
