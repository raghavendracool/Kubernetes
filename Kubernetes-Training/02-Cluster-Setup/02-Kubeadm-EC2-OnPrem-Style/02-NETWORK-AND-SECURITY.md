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

## Demo-Ready Security Group Rules

Use one Security Group attached to all cluster nodes.

### Inbound Rules to Keep

| Type | Port/Range | Source | Why |
|---|---|---|---|
| All traffic | All | Same Security Group (self-reference) | Required node-to-node Kubernetes and CNI communication |
| SSH | TCP 22 | Your admin IP /32 | SSH access for setup and demo |
| Custom TCP | TCP 6443 | Your admin IP /32 | Kubernetes API access from your machine |
| Custom TCP | TCP 30080 | Your admin IP /32 (or temporary 0.0.0.0/0 for classroom) | App-02 NodePort demo access |
| Custom TCP (optional) | TCP 5000 | Your admin IP /32 | Only needed for standalone Docker demo |

### Inbound Rules to Avoid Exposing Publicly

Do not keep these open to 0.0.0.0/0:

- TCP 2379-2380 (etcd)
- TCP 10250 (kubelet)
- TCP 10257 (controller-manager)
- TCP 10259 (scheduler)

These are internal cluster ports and should only be reachable via the self-referencing Security Group rule.

### Optional for Future NodePort Apps

If you want many dynamic NodePort services, open TCP 30000-32767 from a trusted source.
For this training repository, keeping only TCP 30080 open is safer and simpler.
