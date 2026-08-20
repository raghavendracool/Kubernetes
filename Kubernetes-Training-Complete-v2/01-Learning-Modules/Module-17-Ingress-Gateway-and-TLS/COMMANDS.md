# Module 17 — Ingress, Gateway Concepts and TLS: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List ingress classes

```bash
kubectl get ingressclass
```

**Why:** Use this when you need to list ingress classes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List ingress

```bash
kubectl get ingress -A
```

**Why:** Use this when you need to list ingress. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe ingress

```bash
kubectl describe ingress <name> -n <namespace>
```

**Why:** Use this when you need to describe ingress. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create TLS secret

```bash
kubectl create secret tls web-tls --cert=tls.crt --key=tls.key -n web
```

**Why:** Use this when you need to create tls secret. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
