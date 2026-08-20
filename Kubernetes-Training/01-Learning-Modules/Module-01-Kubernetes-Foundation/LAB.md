# Module 01 — Kubernetes Foundation: Hands-On Lab

## Objective
Build a mental map of the cluster without creating an application.

```bash
kubectl version --client
kubectl cluster-info
kubectl get nodes -o wide
kubectl api-resources
kubectl api-versions
kubectl get namespaces
```

Choose five resources from `kubectl api-resources` and answer: namespaced or cluster-scoped? API group? short name?

```bash
kubectl explain pod
kubectl explain deployment
kubectl explain service
```

### Pass Criteria
- Explain desired state and reconciliation.
- Identify cluster, node, namespace and Pod concepts.
- Explain why kubectl needs a reachable API server and kubeconfig.
