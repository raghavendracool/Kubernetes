# Module 21 — Kubernetes Security and Day-2 Operations: Hands-On Lab

## Objective
Validate secure Pod settings and practice the node-maintenance decision flow.

```bash
kubectl apply -f examples/secure-pod.yaml
kubectl get pod secure-demo
kubectl get pod secure-demo -o yaml | grep -A20 -E 'securityContext|seccomp|capabilities'
```

Verify container user when tools permit:

```bash
kubectl exec secure-demo -- id
```

RBAC review:

```bash
kubectl auth can-i --list
kubectl get clusterrolebinding
```

Node maintenance practice—**do not drain a production node as a classroom test**. On a disposable lab node:

```bash
kubectl cordon <lab-node>
kubectl get nodes
kubectl drain <lab-node> --ignore-daemonsets --delete-emptydir-data
kubectl get pods -A -o wide
kubectl uncordon <lab-node>
```

Explain how PDB, DaemonSets and unmanaged Pods affect drain behavior.

```bash
kubectl delete pod secure-demo --ignore-not-found
```
