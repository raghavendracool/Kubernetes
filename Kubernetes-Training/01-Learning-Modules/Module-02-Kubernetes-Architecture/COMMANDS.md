# Module 02 — Kubernetes Architecture: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show component health signals

```bash
kubectl get --raw='/readyz?verbose'
```

**Why:** Use this when you need to show component health signals. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List nodes

```bash
kubectl get nodes -o wide
```

**Why:** Use this when you need to list nodes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect system pods

```bash
kubectl get pods -n kube-system -o wide
```

**Why:** Use this when you need to inspect system pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe node

```bash
kubectl describe node <node-name>
```

**Why:** Use this when you need to describe node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
