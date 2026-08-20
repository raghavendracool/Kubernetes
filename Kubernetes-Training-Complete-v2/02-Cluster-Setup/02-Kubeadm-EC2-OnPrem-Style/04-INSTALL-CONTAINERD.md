# 4. Install and Configure containerd on All Nodes

## Install

```bash
sudo apt-get update
sudo apt-get install -y containerd
```

## Create Default Configuration

```bash
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null
```

## Use systemd cgroups

Kubelet and the container runtime should use compatible cgroup management.

```bash
sudo sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
```

Verify the setting:

```bash
grep -n 'SystemdCgroup' /etc/containerd/config.toml
```

## Restart and Enable

```bash
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd --no-pager
```

## Useful Runtime Checks

```bash
containerd --version
sudo crictl info
```

If `crictl` reports endpoint warnings before kubeadm packages are fully configured, continue with the next step and validate the runtime again afterward.
