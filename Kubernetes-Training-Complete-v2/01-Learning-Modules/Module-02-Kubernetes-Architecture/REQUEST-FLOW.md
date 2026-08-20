# Kubernetes Request Flow — Step by Step

Example: `kubectl apply -f deployment.yaml`

```text
1. kubectl reads kubeconfig.
2. kubectl authenticates to kube-apiserver.
3. API server authenticates and authorizes the request.
4. Admission checks/mutates the object.
5. Valid desired state is persisted.
6. Deployment controller sees the new Deployment.
7. It creates/updates a ReplicaSet.
8. ReplicaSet controller creates Pod objects.
9. Scheduler finds unscheduled Pods and selects nodes.
10. kubelet on each selected node sees the Pod assignment.
11. kubelet asks the container runtime to pull images/start containers.
12. CNI configures Pod networking.
13. kubelet continuously reports Pod/container status.
14. Controllers keep reconciling until desired state is satisfied.
```

## Commands to observe the flow

```bash
kubectl get deployment,rs,pods -w
kubectl get events --sort-by=.lastTimestamp
kubectl describe deployment <name>
kubectl describe rs <name>
kubectl describe pod <name>
```
