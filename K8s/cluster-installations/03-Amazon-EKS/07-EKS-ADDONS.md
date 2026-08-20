# 07 — EKS Add-ons

```bash
aws eks list-addons --cluster-name sdhub-k8s --region ap-south-1

aws eks describe-addon-versions   --kubernetes-version 1.36   --region ap-south-1
```

Understand:
- VPC CNI
- CoreDNS
- kube-proxy
- EBS CSI
- Pod Identity Agent
