# Module 13 — Scheduling, Affinity, Taints and Tolerations: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show node labels

```bash
kubectl get nodes --show-labels
```

**Why:** Use this when you need to show node labels. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Add node label

```bash
kubectl label node <node> workload=apps
```

**Why:** Use this when you need to add node label. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Taint node

```bash
kubectl taint nodes <node> dedicated=platform:NoSchedule
```

**Why:** Use this when you need to taint node. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Remove taint

```bash
kubectl taint nodes <node> dedicated=platform:NoSchedule-
```

**Why:** Use this when you need to remove taint. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Show pod node assignment

```bash
kubectl get pods -o wide
```

**Why:** Use this when you need to show pod node assignment. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
