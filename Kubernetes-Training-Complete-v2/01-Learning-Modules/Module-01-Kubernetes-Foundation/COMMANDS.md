# Module 01 — Kubernetes Foundation: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Inspect kubectl client

```bash
kubectl version --client
```

**Why:** Use this when you need to inspect kubectl client. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### View cluster information

```bash
kubectl cluster-info
```

**Why:** Use this when you need to view cluster information. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List API resources

```bash
kubectl api-resources
```

**Why:** Use this when you need to list api resources. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List API versions

```bash
kubectl api-versions
```

**Why:** Use this when you need to list api versions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Explain a resource

```bash
kubectl explain pod
```

**Why:** Use this when you need to explain a resource. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
