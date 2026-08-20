# Worker Node Components

## kubelet

Node agent that:
- watches assigned Pods;
- starts/stops containers through the runtime;
- runs probes;
- reports node/Pod status.

## containerd

Course runtime for kubeadm.

```text
kubelet → CRI → containerd → container
```

## CNI

Provides Pod networking.

Self-managed course: Calico.

## kube-proxy / Service Data Plane

Traditional kube-proxy programs node networking rules for Service traffic. Modern data planes may implement Service behavior differently.

## CoreDNS

Provides Kubernetes DNS so applications use stable names such as:

```text
student-web.student-app.svc.cluster.local
```
