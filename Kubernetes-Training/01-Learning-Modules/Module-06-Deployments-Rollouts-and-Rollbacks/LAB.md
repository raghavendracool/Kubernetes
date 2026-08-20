# Module 06 — ReplicaSets, Deployments, Rollouts and Rollbacks: Hands-On Lab

## Objective
See ReplicaSet revisions created during a Deployment rollout.

```bash
kubectl create namespace rollout-lab
kubectl create deployment web --image=nginx:1.27 -n rollout-lab
kubectl scale deployment web --replicas=3 -n rollout-lab
kubectl get deploy,rs,pods -n rollout-lab
```

Update:

```bash
kubectl set image deployment/web nginx=nginx:1.28 -n rollout-lab
kubectl rollout status deployment/web -n rollout-lab
kubectl get rs -n rollout-lab
kubectl rollout history deployment/web -n rollout-lab
```

Create a bad rollout:

```bash
kubectl set image deployment/web nginx=nginx:bad-tag -n rollout-lab
kubectl rollout status deployment/web -n rollout-lab --timeout=30s || true
kubectl get pods -n rollout-lab
kubectl describe deployment web -n rollout-lab
```

Rollback:

```bash
kubectl rollout undo deployment/web -n rollout-lab
kubectl rollout status deployment/web -n rollout-lab
kubectl delete namespace rollout-lab
```
