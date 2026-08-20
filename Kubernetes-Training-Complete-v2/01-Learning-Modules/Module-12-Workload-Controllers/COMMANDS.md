# Module 12 — StatefulSet, DaemonSet, Job and CronJob: Command Sheet

## Before You Start

```bash
kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
```

## Topic Commands

### List controller types

```bash
kubectl get deploy,sts,ds,job,cronjob -A
```

**Why:** Use this when you need to list controller types. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create job from command

```bash
kubectl create job hello --image=busybox:1.36 -- echo hello
```

**Why:** Use this when you need to create job from command. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Create cronjob

```bash
kubectl create cronjob heartbeat --image=busybox:1.36 --schedule="*/5 * * * *" -- echo heartbeat
```

**Why:** Use this when you need to create cronjob. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

### Job logs

```bash
kubectl logs job/hello
```

**Why:** Use this when you need to job logs. After running it, verify the result with `kubectl get`, `kubectl describe`, or a more specific status command.

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
