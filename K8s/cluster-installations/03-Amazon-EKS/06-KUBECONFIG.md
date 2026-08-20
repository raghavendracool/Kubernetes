# 06 — kubeconfig

```bash
aws eks update-kubeconfig --name sdhub-k8s --region ap-south-1
kubectl config current-context
kubectl config get-contexts
kubectl cluster-info
```

kubeconfig configures cluster/client authentication information; Kubernetes authorization is still evaluated separately.
