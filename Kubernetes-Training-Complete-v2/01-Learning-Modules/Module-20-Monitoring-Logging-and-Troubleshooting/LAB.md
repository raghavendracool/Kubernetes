# Module 20 — Monitoring, Logging and Troubleshooting: Hands-On Lab

## Objective
Diagnose three intentionally broken workloads using evidence.

```bash
kubectl create namespace breakfix
kubectl run bad-image --image=nginx:no-such-tag -n breakfix
kubectl run crash --image=busybox:1.36 -n breakfix -- sh -c 'echo starting; exit 1'
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pending
  namespace: breakfix
spec:
  containers:
    - name: web
      image: nginx:alpine
      resources:
        requests:
          cpu: "100000"
EOF
```

For each failure use:

```bash
kubectl get pods -n breakfix -o wide
kubectl describe pod <pod> -n breakfix
kubectl logs <pod> -n breakfix
kubectl logs <pod> -n breakfix --previous
kubectl get events -n breakfix --sort-by=.lastTimestamp
```

Document:

```text
Symptom:
Evidence:
Root cause:
Fix:
Validation command:
```

Also inspect cluster resources:

```bash
kubectl top nodes 2>/dev/null || true
kubectl get nodes
```

```bash
kubectl delete namespace breakfix
```
