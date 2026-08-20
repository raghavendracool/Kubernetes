# RBAC Cheat Sheet

```text
User / Group / ServiceAccount
          ↓
RoleBinding / ClusterRoleBinding
          ↓
Role / ClusterRole
          ↓
verbs on API resources
```

Validate with:

```bash
kubectl auth can-i <verb> <resource> -n <namespace>
```
