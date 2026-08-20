# 1. Architecture and EC2 Servers

## Recommended Lab Size

| Server | Purpose | OS | Suggested type | Disk |
|---|---|---|---|---|
| `k8s-cp-01` | Control plane | Ubuntu 24.04 LTS | t3.medium | 20 GiB gp3 |
| `k8s-worker-01` | Worker | Ubuntu 24.04 LTS | t3.medium | 20 GiB gp3 |
| `k8s-worker-02` | Worker | Ubuntu 24.04 LTS | t3.medium | 20 GiB gp3 |

For a learning cluster, place the three instances in the same VPC and preferably the same private network path so node-to-node communication is straightforward.

## Hostnames

On each instance set the intended hostname:

```bash
# control plane
sudo hostnamectl set-hostname k8s-cp-01

# worker 1
sudo hostnamectl set-hostname k8s-worker-01

# worker 2
sudo hostnamectl set-hostname k8s-worker-02
```

Verify:

```bash
hostname
hostname -I
ip addr
ip route
```

## Capture Private IPs

Create a small note before continuing:

```text
CONTROL_PLANE_IP=<private-ip>
WORKER_1_IP=<private-ip>
WORKER_2_IP=<private-ip>
```

Kubernetes node communication should use the stable internal/private network path, not random public addresses.
