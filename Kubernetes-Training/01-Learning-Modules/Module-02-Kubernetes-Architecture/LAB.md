# Module 02 — Kubernetes Architecture: Hands-On Lab

## Objective
Observe control-plane and node components through Kubernetes-visible evidence.

```bash
kubectl get nodes -o wide
kubectl get pods -n kube-system -o wide
kubectl get --raw='/readyz?verbose'
kubectl describe node $(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
```

Create a tiny Deployment and watch object creation:

```bash
kubectl create namespace arch-lab
kubectl create deployment web --image=nginx:alpine -n arch-lab
kubectl get deployment,rs,pods -n arch-lab -w
```

In a second terminal:

```bash
kubectl get events -n arch-lab --sort-by=.lastTimestamp -w
```

Explain the sequence Deployment → ReplicaSet → Pod → scheduler → kubelet.

```bash
kubectl delete namespace arch-lab
```
