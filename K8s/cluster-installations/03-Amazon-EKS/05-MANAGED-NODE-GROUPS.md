# 05 — Managed Node Groups

```text
EKS Control Plane → Managed Node Group → Auto Scaling Group → EC2 Nodes → Pods
```

Inspect:

```bash
eksctl get nodegroup --cluster sdhub-k8s --region ap-south-1
kubectl get nodes -L eks.amazonaws.com/nodegroup
```

Teach desired/min/max, instance types, labels, taints and updates.
