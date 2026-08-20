# Detailed Notes — Helm

## Chart Structure

Typical chart:

```text
Chart.yaml
values.yaml
templates/
  deployment.yaml
  service.yaml
```

Templates are Go-template-based YAML. Values provide parameters such as image tag, replica count and resource configuration.

## Safe Workflow

```bash
helm lint ./chart
helm template myapp ./chart -f values-dev.yaml > rendered.yaml
kubectl apply --dry-run=server -f rendered.yaml
helm upgrade --install myapp ./chart -f values-dev.yaml
```

Rendering makes it easier to review the actual Kubernetes objects before changing a cluster.

## Release Operations

```bash
helm list -A
helm status myapp -n app
helm get values myapp -n app
helm get manifest myapp -n app
helm history myapp -n app
helm rollback myapp <revision> -n app
```

Helm rollback only covers resources represented in the Helm release; external schema/data migrations still need their own rollback strategy.
