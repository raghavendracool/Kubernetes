# Module 19 — Helm: Hands-On Lab

## Objective
Create, render, install, upgrade and roll back a Helm release.

```bash
helm version
mkdir -p /tmp/helm-lab && cd /tmp/helm-lab
helm create student-web
helm lint student-web
helm template student-web student-web > rendered.yaml
```

Inspect rendered Deployment/Service:

```bash
grep -n '^kind:' rendered.yaml
kubectl apply --dry-run=server -f rendered.yaml
```

Install:

```bash
helm upgrade --install student-web student-web -n helm-lab --create-namespace
helm list -n helm-lab
helm status student-web -n helm-lab
helm history student-web -n helm-lab
```

Change `replicaCount` or image tag, upgrade, inspect history, then rollback:

```bash
helm rollback student-web 1 -n helm-lab
helm uninstall student-web -n helm-lab
kubectl delete namespace helm-lab --ignore-not-found
```
