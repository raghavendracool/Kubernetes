# Module 05 — Pods and Pod Lifecycle: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Run temporary pod

```bash
kubectl run nginx-lab --image=nginx:alpine
```

**Why:** Use this when you need to run temporary pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect pod

```bash
kubectl get pod nginx-lab -o wide
```

**Why:** Use this when you need to inspect pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe pod

```bash
kubectl describe pod nginx-lab
```

**Why:** Use this when you need to describe pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Read logs

```bash
kubectl logs nginx-lab
```

**Why:** Use this when you need to read logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Execute command

```bash
kubectl exec -it nginx-lab -- sh
```

**Why:** Use this when you need to execute command. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Delete pod

```bash
kubectl delete pod nginx-lab
```

**Why:** Use this when you need to delete pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
