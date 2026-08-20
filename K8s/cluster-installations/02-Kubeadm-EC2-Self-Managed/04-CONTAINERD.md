# 04 — Install containerd (All Nodes)

```bash
sudo apt-get update
sudo apt-get install -y containerd
sudo mkdir -p /etc/containerd
containerd config default | sudo tee /etc/containerd/config.toml
```

Ensure the runc runtime uses:

```text
SystemdCgroup = true
```

Then:

```bash
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl status containerd --no-pager
containerd --version
```
