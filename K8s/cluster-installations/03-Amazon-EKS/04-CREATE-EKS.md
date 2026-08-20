# 04 — Create EKS with eksctl

```bash
cd cluster-installations/03-Amazon-EKS/eksctl
eksctl create cluster -f cluster.yaml
```

Validate AWS:

```bash
aws eks describe-cluster   --name sdhub-k8s   --region ap-south-1   --query 'cluster.{name:name,version:version,status:status,endpoint:endpoint}'
```

Validate Kubernetes:

```bash
kubectl get nodes -o wide
kubectl get pods -A
```
