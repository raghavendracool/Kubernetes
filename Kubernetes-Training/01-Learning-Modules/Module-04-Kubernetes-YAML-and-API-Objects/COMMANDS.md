# Module 04 — Kubernetes YAML and API Objects: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create YAML without creating object

```bash
kubectl create deployment demo --image=nginx --dry-run=client -o yaml
```

**Why:** Use this when you need to create yaml without creating object. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Validate apply

```bash
kubectl apply --dry-run=server -f example.yaml
```

**Why:** Use this when you need to validate apply. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Preview difference

```bash
kubectl diff -f example.yaml
```

**Why:** Use this when you need to preview difference. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Apply manifest

```bash
kubectl apply -f example.yaml
```

**Why:** Use this when you need to apply manifest. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Get object YAML

```bash
kubectl get deployment demo -o yaml
```

**Why:** Use this when you need to get object yaml. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
