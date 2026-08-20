# Detailed Notes — Kubernetes YAML and API Objects

## Anatomy

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
  namespace: demo
  labels:
    app: web
spec:
  replicas: 3
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: nginx:1.28
```

`apiVersion` + `kind` identify the schema. `metadata.name` and namespace identify the object. `spec` is the desired state.

## Why Status Is Usually Not in Git

Controllers and kubelets continuously update `status` to report observed state. You normally author `spec`; Kubernetes owns most `status` fields.

## Declarative Workflow

```bash
kubectl apply --dry-run=server -f app.yaml
kubectl diff -f app.yaml
kubectl apply -f app.yaml
```

Server-side dry run catches schema/admission problems using the actual API server. `diff` shows intended changes before mutation.

## API Lifecycle

Kubernetes APIs evolve. Before a cluster upgrade, scan manifests/Helm output for deprecated or removed versions. A manifest that worked on an old cluster may be rejected after an API removal.
