# Module 07 — Labels, Selectors, Annotations and Namespaces: Hands-On Lab

## Objective
Prove how selectors depend on labels.

```bash
kubectl create namespace label-lab
kubectl create deployment web --image=nginx:alpine --replicas=2 -n label-lab
kubectl label deployment web owner=platform -n label-lab
kubectl get deployment web -n label-lab --show-labels
kubectl get pods -n label-lab --show-labels
```

Create a Service with the correct selector:

```bash
kubectl expose deployment web --port=80 --target-port=80 -n label-lab
kubectl get svc,endpointslice -n label-lab
```

Inspect Pod labels, then intentionally edit the Service selector to a non-matching value:

```bash
kubectl edit service web -n label-lab
kubectl get endpointslice -n label-lab -o wide
```

Restore `app=web` and verify endpoints return.

```bash
kubectl annotate deployment web runbook='training-demo' -n label-lab
kubectl delete namespace label-lab
```
