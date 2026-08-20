# Module 15 — Kubernetes Networking and CNI: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Pod IPs

```bash
kubectl get pods -A -o wide
```

**Why:** Use this when you need to pod ips. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Node routes

```bash
ip route
```

**Why:** Use this when you need to node routes. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### System networking pods

```bash
kubectl get pods -n kube-system -o wide
```

**Why:** Use this when you need to system networking pods. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### DNS test

```bash
kubectl run nettest --rm -it --restart=Never --image=busybox:1.36 -- sh
```

**Why:** Use this when you need to dns test. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect service endpoints

```bash
kubectl get endpointslices -A
```

**Why:** Use this when you need to inspect service endpoints. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
