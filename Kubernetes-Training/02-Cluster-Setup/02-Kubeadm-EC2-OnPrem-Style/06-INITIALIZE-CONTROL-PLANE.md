# 6. Initialize the Control Plane

Run only on `k8s-cp-01`.

## Preflight

```bash
sudo systemctl is-active containerd
sudo systemctl status kubelet --no-pager
ip addr
```

## Initialize

Replace `<CONTROL_PLANE_PRIVATE_IP>` with the private IP of `k8s-cp-01`.

```bash
sudo kubeadm init \
  --apiserver-advertise-address=<CONTROL_PLANE_PRIVATE_IP> \
  --pod-network-cidr=192.168.0.0/16
```

**Save the `kubeadm join ...` command printed at the end.** It contains a short-lived bootstrap token and CA hash used by workers.

## Configure kubectl for ubuntu User

```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

## Inspect Initial State

```bash
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -n kube-system -o wide
```

The control-plane node will normally remain `NotReady` until a CNI plugin is installed.

## Generate a New Join Command Later

```bash
kubeadm token create --print-join-command
```
