# Module 09 — ConfigMaps and Secrets: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create ConfigMap

```bash
kubectl create configmap app-config --from-literal=APP_ENV=dev
```

**Why:** Use this when you need to create configmap. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create generic Secret

```bash
kubectl create secret generic db-secret --from-literal=username=appuser --from-literal=password=change-me
```

**Why:** Use this when you need to create generic secret. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect ConfigMap

```bash
kubectl get configmap app-config -o yaml
```

**Why:** Use this when you need to inspect configmap. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Decode secret value

```bash
kubectl get secret db-secret -o jsonpath='{.data.username}' | base64 -d; echo
```

**Why:** Use this when you need to decode secret value. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

## Universal Inspection Commands

```bash
# Wide output includes node/IP information where applicable
kubectl get <resource> -o wide

# Full desired + observed object representation
kubectl get <resource> <name> -o yaml

# Human-readable state, conditions and events
kubectl describe <resource> <name>

# Watch changes live
kubectl get <resource> -w

# Show recent events
kubectl get events --sort-by=.lastTimestamp

# Explain schema fields
kubectl explain <resource>
kubectl explain <resource>.spec
```

## Useful Output Formats

```bash
kubectl get pods -o name
kubectl get pods -o wide
kubectl get pods -o yaml
kubectl get pods -o json
kubectl get pods -o custom-columns=NAME:.metadata.name,NODE:.spec.nodeName,PHASE:.status.phase
```

## Safety Commands Before a Change

```bash
kubectl config current-context
kubectl config view --minify
kubectl diff -f <manifest.yaml>
kubectl apply --dry-run=server -f <manifest.yaml>
```
