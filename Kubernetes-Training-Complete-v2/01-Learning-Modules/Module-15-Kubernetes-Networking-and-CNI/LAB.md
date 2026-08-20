# Module 15 — Kubernetes Networking and CNI: Hands-On Lab

## Objective
Test Pod-to-Pod, Service and DNS layers separately.

```bash
kubectl create namespace net-lab
kubectl create deployment web --image=nginx:alpine --replicas=2 -n net-lab
kubectl expose deployment web --port=80 -n net-lab
kubectl get pods -n net-lab -o wide
kubectl get svc,endpointslice -n net-lab
```

Start a debug shell:

```bash
kubectl run net-debug --rm -it --restart=Never --image=busybox:1.36 -n net-lab -- sh
```

Inside the Pod:

```sh
ip addr
ip route
nslookup web
wget -qO- http://web
```

Back on a node/self-managed cluster, inspect:

```bash
ip route
ip link show | egrep 'cali|vxlan|cni' || true
```

Explain which test proves DNS, Service routing and Pod network reachability.

```bash
kubectl delete namespace net-lab
```
