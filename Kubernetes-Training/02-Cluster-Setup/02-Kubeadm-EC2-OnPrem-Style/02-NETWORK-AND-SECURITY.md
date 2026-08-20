# 2. Network and Security Groups

For a training cluster, the simplest safe model is:

- One cluster Security Group attached to all three nodes.
- Allow **all traffic from the same Security Group to itself** so control-plane, kubelet and CNI traffic can flow between nodes.
- Allow SSH TCP/22 only from your admin public IP `/32` if SSH is required.
- Allow Kubernetes API TCP/6443 only from your trusted admin source if you plan to use kubectl directly against the public path.
- Do not expose etcd ports to the internet.

## Kubernetes Ports to Understand

### Control plane

| Port | Purpose |
|---|---|
| TCP 6443 | Kubernetes API server |
| TCP 2379-2380 | etcd client/peer |
| TCP 10250 | kubelet API |
| TCP 10257 | controller-manager secure port |
| TCP 10259 | scheduler secure port |

### Worker

| Port | Purpose |
|---|---|
| TCP 10250 | kubelet API |
| TCP 30000-32767 | default NodePort range when NodePort is used |

CNI networking can require additional protocol/port allowances. A self-referencing cluster SG avoids having to open every internal CNI port individually in a learning environment.

## Linux Connectivity Tests

From each node:

```bash
ping -c 3 <other-node-private-ip>
nc -vz <control-plane-private-ip> 6443
```

Before kubeadm init, TCP/6443 will not yet be listening; after initialization it should be reachable.
