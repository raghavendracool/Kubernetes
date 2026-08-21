# Module 08 — Services, DNS and Service Discovery: Hands-On Lab

## Objective
Trace traffic from DNS name to Service to EndpointSlice to Pods.

```bash
kubectl create namespace svc-lab
kubectl create deployment api --image=nginx:alpine --replicas=2 -n svc-lab
kubectl expose deployment api --name=api --port=80 --target-port=80 -n svc-lab
kubectl get pod,svc,endpointslice -n svc-lab -o wide
```

DNS and HTTP test from inside cluster:

```bash
kubectl run client --rm -it --restart=Never --image=busybox:1.36 -n svc-lab -- nslookup api.svc-lab.svc.cluster.local
kubectl run curl --rm -it --restart=Never --image=curlimages/curl -n svc-lab -- curl -sS http://api
```

Break the Service by changing its selector:

```bash
kubectl patch service api -n svc-lab -p '{"spec":{"selector":{"app":"wrong"}}}'
kubectl get endpointslice -n svc-lab
```

Explain why DNS can still resolve while the Service has no working backend. Restore selector:

```bash
kubectl patch service api -n svc-lab -p '{"spec":{"selector":{"app":"api"}}}'
kubectl delete namespace svc-lab
```

## Service Type Comparison Lab

Use this mini-lab to compare object shape and runtime behavior across Service types.

```bash
kubectl create namespace svc-types
kubectl create deployment demo --image=nginx:alpine --replicas=2 -n svc-types
kubectl label deployment demo app=svc-demo -n svc-types --overwrite
kubectl patch deployment demo -n svc-types -p '{"spec":{"template":{"metadata":{"labels":{"app":"svc-demo"}}}}}'
kubectl rollout status deployment demo -n svc-types
```

Apply all example Service manifests:

```bash
kubectl apply -f examples/01-clusterip.yaml
kubectl apply -f examples/02-nodeport.yaml
kubectl apply -f examples/03-loadbalancer.yaml
kubectl apply -f examples/04-externalname.yaml
```

Inspect and compare:

```bash
kubectl get svc -n svc-types -o wide
kubectl describe svc demo-clusterip -n svc-types
kubectl describe svc demo-nodeport -n svc-types
kubectl describe svc demo-loadbalancer -n svc-types
kubectl describe svc docs-externalname -n svc-types
kubectl get endpointslice -n svc-types -l kubernetes.io/service-name=demo-clusterip
kubectl get endpointslice -n svc-types -l kubernetes.io/service-name=demo-nodeport
kubectl get endpointslice -n svc-types -l kubernetes.io/service-name=demo-loadbalancer
```

Validation questions:

1. Which Service type has no selector/endpoints by design?
2. Which Service type exposes a Node port?
3. In your environment, did `LoadBalancer` receive an external IP? If not, why?

Cleanup:

```bash
kubectl delete namespace svc-types --ignore-not-found
```
