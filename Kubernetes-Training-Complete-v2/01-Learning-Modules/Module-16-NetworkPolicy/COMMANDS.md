# Module 16 — NetworkPolicy: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List policies

```bash
kubectl get networkpolicy -A
```

**Why:** Use this when you need to list policies. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Describe policy

```bash
kubectl describe networkpolicy <policy> -n <namespace>
```

**Why:** Use this when you need to describe policy. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Run connectivity test

```bash
kubectl run curl --rm -it --restart=Never --image=curlimages/curl -- curl -m 3 http://<service>
```

**Why:** Use this when you need to run connectivity test. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
