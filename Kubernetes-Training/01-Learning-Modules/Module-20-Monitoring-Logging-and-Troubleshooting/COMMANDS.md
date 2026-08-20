# Module 20 — Monitoring, Logging and Troubleshooting: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Recent events

```bash
kubectl get events -A --sort-by=.lastTimestamp
```

**Why:** Use this when you need to recent events. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Pod logs

```bash
kubectl logs <pod> --all-containers=true --tail=200
```

**Why:** Use this when you need to pod logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Previous container logs

```bash
kubectl logs <pod> --previous
```

**Why:** Use this when you need to previous container logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Resource metrics

```bash
kubectl top nodes && kubectl top pods -A
```

**Why:** Use this when you need to resource metrics. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe failing pod

```bash
kubectl describe pod <pod> -n <namespace>
```

**Why:** Use this when you need to describe failing pod. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Debug with ephemeral container

```bash
kubectl debug -it pod/<pod> --image=busybox:1.36 --target=<container>
```

**Why:** Use this when you need to debug with ephemeral container. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
