# kubectl Cheat Sheet

## Context
```bash
kubectl config current-context
kubectl config get-contexts
kubectl config use-context <context>
```

## Discovery
```bash
kubectl api-resources
kubectl explain deployment
kubectl explain deployment.spec.template.spec.containers
```

## Get / Inspect
```bash
kubectl get nodes
kubectl get pods -A
kubectl get all -n student-app
kubectl get pods -o wide -n student-app
kubectl describe pod <pod> -n student-app
kubectl get events -n student-app --sort-by=.lastTimestamp
```

## Logs / Exec
```bash
kubectl logs <pod> -n student-app
kubectl logs <pod> --previous -n student-app
kubectl exec -it <pod> -n student-app -- sh
```

## Rollout
```bash
kubectl rollout status deployment/student-web -n student-app
kubectl rollout history deployment/student-web -n student-app
kubectl rollout undo deployment/student-web -n student-app
```

## Node Operations
```bash
kubectl cordon <node>
kubectl drain <node> --ignore-daemonsets --delete-emptydir-data
kubectl uncordon <node>
```

## Authorization
```bash
kubectl auth can-i get pods -n student-app
kubectl auth can-i --list -n student-app
```
