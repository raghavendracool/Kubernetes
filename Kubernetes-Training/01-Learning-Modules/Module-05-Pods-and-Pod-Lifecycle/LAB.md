# Module 05 — Pods and Pod Lifecycle: Hands-On Lab

## Objective
Create a Pod, inspect container state, execute commands and generate a controlled failure.

```bash
kubectl create namespace pod-lab
kubectl run web --image=nginx:alpine -n pod-lab
kubectl wait --for=condition=Ready pod/web -n pod-lab --timeout=120s
kubectl get pod web -n pod-lab -o wide
kubectl describe pod web -n pod-lab
kubectl logs web -n pod-lab
kubectl exec -it web -n pod-lab -- sh
```

Create an image failure:

```bash
kubectl run bad-image --image=nginx:this-tag-does-not-exist -n pod-lab
kubectl get pods -n pod-lab -w
```

Then investigate:

```bash
kubectl describe pod bad-image -n pod-lab
kubectl get events -n pod-lab --sort-by=.lastTimestamp
```

Identify the exact event that explains `ImagePullBackOff`.

```bash
kubectl delete namespace pod-lab
```
