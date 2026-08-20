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
