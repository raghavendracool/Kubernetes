# Module 14 — ServiceAccounts and RBAC: Hands-On Lab

## Objective
Create a namespace-scoped read-only identity and prove allowed/denied actions.

```bash
kubectl create namespace dev --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f examples/rbac-readonly.yaml
```

Test allowed operations:

```bash
kubectl auth can-i get pods -n dev --as=system:serviceaccount:dev:app-reader
kubectl auth can-i list pods -n dev --as=system:serviceaccount:dev:app-reader
```

Test denied operations:

```bash
kubectl auth can-i delete pods -n dev --as=system:serviceaccount:dev:app-reader
kubectl auth can-i create deployments -n dev --as=system:serviceaccount:dev:app-reader
```

Inspect the chain:

```bash
kubectl get sa,role,rolebinding -n dev -o yaml
```

Explain subject → RoleBinding → Role → rules.

```bash
kubectl delete namespace dev
```
