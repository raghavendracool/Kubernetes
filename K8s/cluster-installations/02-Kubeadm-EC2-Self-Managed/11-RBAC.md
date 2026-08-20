# 11 — RBAC Lab

```bash
kubectl apply -f learning-modules/Module-13-ServiceAccounts-and-RBAC/stage/
kubectl auth can-i get pods -n student-app --as=developer
kubectl auth can-i create deployments -n student-app --as=developer
kubectl auth can-i delete nodes --as=developer
```

`--as` demonstrates authorization/impersonation for the lab; it is not the complete production human authentication design.
