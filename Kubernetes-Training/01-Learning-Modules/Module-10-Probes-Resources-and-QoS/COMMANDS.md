# Module 10 — Probes, Resources and QoS: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### View resource requests

```bash
kubectl get pod <pod> -o jsonpath='{.spec.containers[*].resources}'
```

**Why:** Use this when you need to view resource requests. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Top pods

```bash
kubectl top pods -A
```

**Why:** Use this when you need to top pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe pod conditions

```bash
kubectl describe pod <pod>
```

**Why:** Use this when you need to describe pod conditions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Show restart counts

```bash
kubectl get pods -o custom-columns=NAME:.metadata.name,RESTARTS:.status.containerStatuses[*].restartCount
```

**Why:** Use this when you need to show restart counts. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
