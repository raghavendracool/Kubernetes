# 3. Prepare Ubuntu on All Nodes

Run these steps on **control plane and every worker**.

## Update OS

```bash
sudo apt-get update
sudo apt-get upgrade -y
```

## Disable Swap

Kubernetes expects swap configuration to be intentional. For this training cluster, disable it:

```bash
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab
free -h
swapon --show
```

`swapon --show` should return no active swap.

## Load Kernel Modules

```bash
cat <<'EOF' | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter
```

Verify:

```bash
lsmod | egrep 'overlay|br_netfilter'
```

## Required sysctl Settings

```bash
cat <<'EOF' | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system
```

Verify:

```bash
sysctl net.ipv4.ip_forward
sysctl net.bridge.bridge-nf-call-iptables
```

Expected important value: `net.ipv4.ip_forward = 1`.
