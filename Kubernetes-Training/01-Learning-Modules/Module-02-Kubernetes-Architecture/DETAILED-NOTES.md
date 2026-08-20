# Detailed Notes — Kubernetes Architecture

## Control Plane

### kube-apiserver

All normal cluster operations flow through the API server. kubectl, controllers, schedulers and many extensions communicate with the API, not by editing etcd directly.

### etcd

etcd is the strongly consistent key-value database that stores Kubernetes cluster state. In self-managed Kubernetes, etcd backup/recovery is part of your responsibility. In EKS the control-plane data store is managed by AWS.

### kube-scheduler

The scheduler watches for Pods without a node assignment. It filters nodes that cannot satisfy requirements, scores remaining candidates and writes the selected node into the Pod specification.

### kube-controller-manager

This runs core reconciliation controllers: Deployment/ReplicaSet-related behavior, nodes, endpoints and many other desired-state loops.

## Worker Node

### kubelet

The kubelet watches Pods assigned to its node and ensures their containers are created and kept in the expected state. When a node is NotReady, kubelet health is one of the first checks.

### Container Runtime

containerd commonly pulls images, creates containers and reports runtime state through the CRI integration used by kubelet.

### Networking

CNI configures Pod network interfaces/IPs. Service routing is implemented by kube-proxy or another supported dataplane. CoreDNS provides service discovery.

## Follow a Deployment

```text
kubectl -> API Server -> stored desired state
                    -> Deployment controller -> ReplicaSet
                    -> ReplicaSet controller -> Pods
                    -> Scheduler -> node assignment
                    -> kubelet -> containerd -> containers
                    -> CNI -> Pod network
```

During a demo, watch `Deployment`, `ReplicaSet`, `Pod` and events together to make this architecture visible.
