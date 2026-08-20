# Version Notes

This training uses Kubernetes 1.36 as the primary baseline for new clusters in August 2026.

Amazon EKS currently lists 1.36, 1.35, 1.34 and 1.33 in standard support. For new EKS training clusters, use the latest version supported in your target region unless your application has a version constraint.

For kubeadm, the package repository is version-specific. This course therefore uses the `v1.36` package repository.

Calico examples use v3.32.1. If you update Calico, read the release notes and Kubernetes compatibility matrix first.

## Do not blindly copy versions into production

Always check:

```bash
kubectl version
kubeadm version
aws eks describe-cluster --name <cluster> --query 'cluster.version'
aws eks describe-addon-versions --kubernetes-version <version>
```
