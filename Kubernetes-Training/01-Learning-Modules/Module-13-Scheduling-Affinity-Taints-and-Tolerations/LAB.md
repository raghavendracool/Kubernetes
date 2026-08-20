# Module 13 — Scheduling, Affinity, Taints and Tolerations: Hands-On Lab

## Objective
Make a Pod Pending through scheduling rules, then fix the rule.

```bash
kubectl get nodes --show-labels
NODE=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
kubectl label node "$NODE" workload=apps
kubectl taint node "$NODE" dedicated=platform:NoSchedule
```

Apply the module scheduling example:

```bash
kubectl apply -f examples/scheduling.yaml
kubectl get pod scheduled-demo -o wide
kubectl describe pod scheduled-demo
```

If the Pod does not schedule, read the scheduler event and determine whether other nodes/constraints affect the result.

Remove lab resources:

```bash
kubectl delete pod scheduled-demo --ignore-not-found
kubectl taint node "$NODE" dedicated=platform:NoSchedule-
kubectl label node "$NODE" workload-
```
