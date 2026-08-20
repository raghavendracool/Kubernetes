# Module 03 — kubectl, Contexts and Cluster Inspection: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### Show current context

```bash
kubectl config current-context
```

**Why:** Use this when you need to show current context. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### List contexts

```bash
kubectl config get-contexts
```

**Why:** Use this when you need to list contexts. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Switch context

```bash
kubectl config use-context <context-name>
```

**Why:** Use this when you need to switch context. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Set default namespace

```bash
kubectl config set-context --current --namespace=<namespace>
```

**Why:** Use this when you need to set default namespace. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Get all pods with details

```bash
kubectl get pods -A -o wide
```

**Why:** Use this when you need to get all pods with details. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### JSONPath example

```bash
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.nodeInfo.kubeletVersion}{"\n"}{end}'
```

**Why:** Use this when you need to jsonpath example. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
