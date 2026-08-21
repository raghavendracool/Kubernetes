# Module 04 — Detailed Notes

## 1. Kubernetes Object Request Flow

```text
kubectl / CI pipeline
        |
        v
kube-apiserver
        |
        +--> authenticate caller
        +--> authorize action
        +--> admission processing
        +--> validate schema
        |
        v
etcd stores object
        |
        v
controllers watch changes
```

The CLI is only a client. The API server is the central API entry point.

## 2. Object Identity

For namespaced resources, think of identity as:

```text
namespace + resource type + name
```

Example:

```text
training / Deployment / web
```

## 3. API Discovery Is a Core Skill

Do not teach students to memorize every object.

```bash
kubectl api-resources
kubectl api-versions
```

Key columns in `api-resources`:

```text
NAME
SHORTNAMES
APIVERSION
NAMESPACED
KIND
```

## 4. Built-In vs Custom Resources

Built-in:

```text
Deployment
```

Custom resource example after installing a CRD:

```text
Certificate
```

Check installed CRDs:

```bash
kubectl get crd
```

## 5. Reconciliation

A Deployment with:

```yaml
spec:
  replicas: 3
```

means "keep three replicas", not "create exactly three once".

```text
Desired 3 / Actual 2
         |
         v
Controller detects difference
         |
         v
Creates replacement
         |
Desired 3 / Actual 3
```

## 6. YAML Data Structures

Scalar:

```yaml
replicas: 3
```

Map:

```yaml
labels:
  app: web
  tier: frontend
```

List of maps:

```yaml
containers:
  - name: web
    image: nginx:1.28-alpine
  - name: helper
    image: busybox:1.36
```

## 6A. `kind` Is Object Type, Not a Nested Option

New students commonly confuse top-level `kind` with nested spec options.

- `kind: Service` means this object belongs to the Service API schema.
- `spec.type: NodePort` is one setting inside a Service object.

Think of it this way:

```text
kind = object category
spec.* = desired configuration for that category
```

## 7. Multi-Document Manifests

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: training
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
  namespace: training
```

Apply all objects:

```bash
kubectl apply -f multi.yaml
```

## 8. Validation Workflow

Recommended operational habit:

```text
current context
   ↓
current namespace
   ↓
dry-run
   ↓
diff
   ↓
apply
   ↓
verify
```

Commands:

```bash
kubectl config current-context
kubectl apply --dry-run=server -f app.yaml
kubectl diff -f app.yaml
kubectl apply -f app.yaml
```

## 9. Full Manifest Reading Checklist

For every Kubernetes YAML ask:

1. Which API group/version?
2. Which kind?
3. Name?
4. Namespace?
5. Labels?
6. Desired `spec`?
7. Which other objects are referenced?
8. Which controller/component reacts?
9. What can fail?
10. Which command proves success?
