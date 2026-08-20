# Detailed Notes — ServiceAccounts and RBAC

## Authentication vs Authorization

Authentication answers **who are you?** Authorization answers **may you perform this action?** A `Forbidden` error usually means authentication succeeded but authorization denied the request.

## RBAC Building Blocks

- `Role`: permissions scoped to one namespace.
- `ClusterRole`: cluster-scoped permissions or a reusable permission set.
- `RoleBinding`: binds Role/ClusterRole permissions inside one namespace.
- `ClusterRoleBinding`: grants across the cluster.

## Example Permission

```yaml
rules:
- apiGroups: [""]
  resources: ["pods", "pods/log"]
  verbs: ["get", "list", "watch"]
```

This is much safer than `resources: ["*"]`, `verbs: ["*"]`.

## Test Before Handing Access Out

```bash
kubectl auth can-i list pods --as=system:serviceaccount:dev:app-reader -n dev
```

In EKS, AWS IAM/EKS access determines entry to the cluster API, while Kubernetes RBAC can still determine Kubernetes permissions depending on the chosen access model.
