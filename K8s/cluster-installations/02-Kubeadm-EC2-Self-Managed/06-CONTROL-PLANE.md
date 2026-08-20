# 06 — Initialize Control Plane

Run only on control plane:

```bash
sudo kubeadm init --pod-network-cidr=192.168.0.0/16
```

Save the generated worker join command.

Configure kubectl:

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Validate:

```bash
kubectl cluster-info
kubectl get nodes
kubectl get pods -n kube-system
```

`NotReady` before CNI is a useful teaching point.
