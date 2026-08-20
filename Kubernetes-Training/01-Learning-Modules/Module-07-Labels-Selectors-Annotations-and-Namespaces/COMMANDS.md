# Module 07 — Labels, Selectors, Annotations and Namespaces: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create namespace

```bash
kubectl create namespace dev
```

**Why:** Use this when you need to create namespace. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Label namespace

```bash
kubectl label namespace dev environment=dev
```

**Why:** Use this when you need to label namespace. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List labels

```bash
kubectl get pods --show-labels
```

**Why:** Use this when you need to list labels. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Filter by label

```bash
kubectl get pods -l app=web
```

**Why:** Use this when you need to filter by label. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Add annotation

```bash
kubectl annotate deployment web owner=platform-team
```

**Why:** Use this when you need to add annotation. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
