# 11 — EBS CSI

Mental model:

```text
PVC → StorageClass → EBS CSI → EBS Volume
```

Check compatible versions:

```bash
aws eks describe-addon-versions   --addon-name aws-ebs-csi-driver   --kubernetes-version 1.36   --region ap-south-1
```

Validate after installation:

```bash
kubectl get csidriver
kubectl get storageclass
kubectl get pvc -A
```
