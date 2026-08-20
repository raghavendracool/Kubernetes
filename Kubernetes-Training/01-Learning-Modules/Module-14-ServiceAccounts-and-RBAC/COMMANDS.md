# Module 14 — ServiceAccounts and RBAC: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Create service account

```bash
kubectl create serviceaccount app-reader -n dev
```

**Why:** Use this when you need to create service account. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Test current permissions

```bash
kubectl auth can-i get pods -n dev
```

**Why:** Use this when you need to test current permissions. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Test as service account

```bash
kubectl auth can-i list pods -n dev --as=system:serviceaccount:dev:app-reader
```

**Why:** Use this when you need to test as service account. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List roles

```bash
kubectl get role,rolebinding -A
```

**Why:** Use this when you need to list roles. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List cluster roles

```bash
kubectl get clusterrole,clusterrolebinding
```

**Why:** Use this when you need to list cluster roles. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
