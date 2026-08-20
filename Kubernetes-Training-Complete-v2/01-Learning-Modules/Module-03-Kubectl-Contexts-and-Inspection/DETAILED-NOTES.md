# Detailed Notes — kubectl, Contexts and Inspection

## kubeconfig Structure

A kubeconfig normally contains three reusable lists:

- `clusters`: API endpoints and CA information;
- `users`: credentials/authentication methods;
- `contexts`: a cluster + user + optional default namespace combination.

The current context determines where kubectl sends commands.

## Production Safety Habit

Before `apply`, `delete`, `scale`, `rollout undo` or `drain`, run:

```bash
kubectl config current-context
kubectl config view --minify
```

A valid command against the wrong context is still a serious incident.

## Resource Discovery

Do not guess plural names or API groups:

```bash
kubectl api-resources
kubectl api-resources --api-group=apps
kubectl explain deployment
kubectl explain deployment.spec.strategy
```

## Read-Only Inspection Patterns

```bash
kubectl get pods -A -o wide
kubectl get deployment -A
kubectl get pod <name> -o yaml
kubectl describe pod <name>
kubectl get events --sort-by=.lastTimestamp
```

`get` is best for inventory/state. `describe` combines relevant fields, conditions and events. `-o yaml/json` is best when you need the exact object representation.
