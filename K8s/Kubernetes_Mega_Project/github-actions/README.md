# CI/CD Target

```text
Checkout
 ↓
Tests
 ↓
Build Image
 ↓
Scan Image
 ↓
Push Registry
 ↓
Helm Lint / Template
 ↓
Deploy
 ↓
Rollout Status
 ↓
Post-deploy Checks
```

Prefer OIDC/federated AWS authentication rather than long-lived AWS access keys.
