# Module 19 — Helm: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Check Helm

```bash
helm version
```

**Why:** Use this when you need to check helm. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create chart

```bash
helm create student-web
```

**Why:** Use this when you need to create chart. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Lint

```bash
helm lint student-web
```

**Why:** Use this when you need to lint. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Render locally

```bash
helm template demo student-web
```

**Why:** Use this when you need to render locally. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Install

```bash
helm upgrade --install demo student-web -n demo --create-namespace
```

**Why:** Use this when you need to install. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### History

```bash
helm history demo -n demo
```

**Why:** Use this when you need to history. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Rollback

```bash
helm rollback demo 1 -n demo
```

**Why:** Use this when you need to rollback. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Uninstall

```bash
helm uninstall demo -n demo
```

**Why:** Use this when you need to uninstall. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
