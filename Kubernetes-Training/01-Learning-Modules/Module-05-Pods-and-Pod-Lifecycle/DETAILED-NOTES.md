# Detailed Notes — Pods and Pod Lifecycle

## Why a Pod Exists

Kubernetes does not normally schedule a bare container. It schedules a Pod. All containers in that Pod are placed on the same node and share the Pod IP. Use multiple containers only when their lifecycle and locality are tightly coupled.

## Common Container Patterns

- main application container;
- init container that runs before the application;
- helper/sidecar container for tightly coupled functionality.

## States to Distinguish

Pod `phase` such as Pending/Running is not the same as container `state` such as Waiting/Running/Terminated. A Pod can be Running while one container is repeatedly crashing.

## Debug Order

```bash
kubectl get pod <pod> -o wide
kubectl describe pod <pod>
kubectl logs <pod> -c <container>
kubectl logs <pod> -c <container> --previous
kubectl exec -it <pod> -c <container> -- sh
```

Events tell you orchestration/runtime problems; logs tell you application output.

## Why Bare Pods Are Rare in Production

If you delete a bare Pod, nothing recreates it. If the same Pod template is owned by a Deployment, ReplicaSet reconciliation creates a replacement.
