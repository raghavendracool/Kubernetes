# 18 — EKS Troubleshooting

Access:

```bash
aws sts get-caller-identity
aws eks list-access-entries --cluster-name sdhub-k8s --region ap-south-1
aws eks update-kubeconfig --name sdhub-k8s --region ap-south-1
kubectl auth can-i --list
```

Nodes/add-ons:

```bash
kubectl get nodes -o wide
kubectl get pods -n kube-system
aws eks list-addons --cluster-name sdhub-k8s --region ap-south-1
```

Ingress:

```bash
kubectl describe ingress -n student-app
kubectl logs -n kube-system deployment/aws-load-balancer-controller
```

Storage:

```bash
kubectl describe pvc -n student-app
kubectl get storageclass
kubectl get csidriver
```
