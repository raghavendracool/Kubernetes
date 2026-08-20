# Module 18 — Autoscaling, Availability and PDB: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List HPA

```bash
kubectl get hpa -A
```

**Why:** Use this when you need to list hpa. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe HPA

```bash
kubectl describe hpa <name>
```

**Why:** Use this when you need to describe hpa. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Watch replicas

```bash
kubectl get deploy,hpa -w
```

**Why:** Use this when you need to watch replicas. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List PDBs

```bash
kubectl get pdb -A
```

**Why:** Use this when you need to list pdbs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Top pods

```bash
kubectl top pods
```

**Why:** Use this when you need to top pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
