# Module 06 — ReplicaSets, Deployments, Rollouts and Rollbacks: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create deployment

```bash
kubectl create deployment web --image=nginx:1.27
```

**Why:** Use this when you need to create deployment. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Scale

```bash
kubectl scale deployment web --replicas=3
```

**Why:** Use this when you need to scale. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Update image

```bash
kubectl set image deployment/web nginx=nginx:1.28
```

**Why:** Use this when you need to update image. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Watch rollout

```bash
kubectl rollout status deployment/web
```

**Why:** Use this when you need to watch rollout. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### History

```bash
kubectl rollout history deployment/web
```

**Why:** Use this when you need to history. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Rollback

```bash
kubectl rollout undo deployment/web
```

**Why:** Use this when you need to rollback. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
