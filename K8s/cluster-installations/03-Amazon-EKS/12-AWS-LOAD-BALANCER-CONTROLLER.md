# 12 — AWS Load Balancer Controller

```text
Ingress / Service
      ↓ watched by
AWS Load Balancer Controller
      ↓ AWS APIs
ALB / NLB
      ↓
Kubernetes workload
```

Installation requires AWS permissions and a Kubernetes workload identity configuration. Use current AWS instructions for controller/chart versions.

Validate:

```bash
kubectl get deployment -n kube-system aws-load-balancer-controller
kubectl logs -n kube-system deployment/aws-load-balancer-controller
```
