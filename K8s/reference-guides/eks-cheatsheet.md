# EKS Cheat Sheet

```bash
aws sts get-caller-identity
aws eks describe-cluster --name sdhub-k8s --region ap-south-1
aws eks update-kubeconfig --name sdhub-k8s --region ap-south-1
aws eks list-access-entries --cluster-name sdhub-k8s --region ap-south-1
aws eks list-addons --cluster-name sdhub-k8s --region ap-south-1
kubectl get nodes -o wide
kubectl get pods -n kube-system
```

Key distinction:

```text
AWS IAM / EKS access
        ≠
Kubernetes RBAC
```
