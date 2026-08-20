# Module 08 — Services, DNS and Service Discovery: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List services

```bash
kubectl get svc -A
```

**Why:** Use this when you need to list services. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Inspect endpoints

```bash
kubectl get endpointslices -l kubernetes.io/service-name=<service>
```

**Why:** Use this when you need to inspect endpoints. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### DNS test

```bash
kubectl run dns-test --rm -it --restart=Never --image=busybox:1.36 -- nslookup kubernetes.default.svc.cluster.local
```

**Why:** Use this when you need to dns test. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Port forward service

```bash
kubectl port-forward svc/<service> 8080:80
```

**Why:** Use this when you need to port forward service. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
