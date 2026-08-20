# Module 21 — Kubernetes Security and Day-2 Operations: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show security context

```bash
kubectl get pod <pod> -o jsonpath='{.spec.securityContext}'
```

**Why:** Use this when you need to show security context. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Cordon node

```bash
kubectl cordon <node>
```

**Why:** Use this when you need to cordon node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Drain node

```bash
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data
```

**Why:** Use this when you need to drain node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Uncordon node

```bash
kubectl uncordon <node>
```

**Why:** Use this when you need to uncordon node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Check API deprecations

```bash
kubectl api-resources
```

**Why:** Use this when you need to check api deprecations. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Review permissions

```bash
kubectl auth can-i --list
```

**Why:** Use this when you need to review permissions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
