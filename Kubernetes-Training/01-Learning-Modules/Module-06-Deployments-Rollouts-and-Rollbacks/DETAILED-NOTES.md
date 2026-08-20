# Detailed Notes — Deployments, ReplicaSets and Rollouts

## Object Relationship

```text
Deployment
   |
   +--> ReplicaSet revision A --> Pods
   |
   +--> ReplicaSet revision B --> Pods   (during/after rollout)
```

You change the Deployment Pod template. Kubernetes creates a new ReplicaSet revision and gradually moves replicas.

## Rolling Update Controls

- `maxSurge`: how many extra Pods can temporarily exist.
- `maxUnavailable`: how many desired replicas can be unavailable during the rollout.

These values affect speed, capacity requirements and availability.

## Rollout Evidence

```bash
kubectl rollout status deployment/web
kubectl get deployment,rs,pods -l app=web
kubectl rollout history deployment/web
```

A successful API update does not mean the application rollout succeeded. Always wait for rollout status and check readiness.

## Rollback

`kubectl rollout undo` switches the Deployment back toward a previous Pod template revision. It does not roll back external database schema changes, cloud resources or other systems automatically, so application rollback planning must be broader than one command.
