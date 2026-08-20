# ⭐ Kubernetes Mega Project — SecureCloudOps Platform

## Goal

Combine the course into one production-style Kubernetes project.

## Target Architecture

```text
Internet
   ↓
AWS ALB
   ↓
Ingress
   ├───────────────┐
   ↓               ↓
Frontend Service   Backend Service
   ↓               ↓
Frontend Pods      Backend Pods
                       ↓
                    PVC / EBS

Cross-cutting:
- ConfigMaps / Secrets
- ServiceAccounts / RBAC
- EKS Pod Identity
- NetworkPolicies
- Probes
- Requests/Limits
- HPA
- PDB
- Helm
- Monitoring
- CI/CD
```

## Delivery Stages

1. Build container images.
2. Push images to registry.
3. Deploy with plain manifests.
4. Add ConfigMap/Secret.
5. Add probes/resources.
6. Add RBAC.
7. Add NetworkPolicies.
8. Add Ingress/TLS.
9. Add HPA/PDB.
10. Add persistent storage.
11. Convert to Helm.
12. Deploy to EKS.
13. Add Pod Identity for AWS service access.
14. Add EBS CSI and AWS Load Balancer Controller.
15. Add monitoring.
16. Automate CI/CD.
17. Run failure drills.
