# What Happens After kubectl apply?

```text
1. Developer
   kubectl apply -f deployment.yaml
          ↓
2. kube-apiserver
   authenticate / authorize / validate
          ↓
3. desired state persisted
          ↓
4. Deployment controller
          ↓
5. ReplicaSet controller
          ↓
6. Pods are required
          ↓
7. Scheduler assigns nodes
          ↓
8. kubelet sees assigned Pod
          ↓
9. containerd starts container
          ↓
10. status returns through API
          ↓
11. controllers keep reconciling
```

## Self-Healing Example

```text
Desired = 3
Actual  = 2
   ↓
Controller sees mismatch
   ↓
New Pod created
   ↓
Scheduler selects node
   ↓
kubelet starts it
```
