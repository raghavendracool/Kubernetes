# 08 — EKS Access Entries

Modern course focus: EKS Access Entries.

```bash
aws eks list-access-entries   --cluster-name sdhub-k8s   --region ap-south-1
```

Create entry for an existing role:

```bash
aws eks create-access-entry   --cluster-name sdhub-k8s   --principal-arn arn:aws:iam::<ACCOUNT_ID>:role/DeveloperRole   --type STANDARD   --region ap-south-1
```

Authorization can be granted with:
1. AWS-managed EKS access policies; or
2. Kubernetes groups mapped to normal Kubernetes RBAC.

Inspect current access policies before associating one:

```bash
aws eks list-access-policies
```
