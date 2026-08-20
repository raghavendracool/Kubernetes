# 09 — Kubernetes RBAC on EKS

```text
IAM Role
 ↓
EKS Access Entry
 ↓ optional Kubernetes group
RoleBinding
 ↓
Role
 ↓
Namespace permissions
```

Use Module 13 RBAC manifests and validate:

```bash
kubectl auth can-i get pods -n student-app
kubectl auth can-i --list -n student-app
```
