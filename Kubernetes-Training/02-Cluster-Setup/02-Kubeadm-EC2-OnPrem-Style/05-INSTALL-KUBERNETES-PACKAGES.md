# 5. Install kubeadm, kubelet and kubectl on All Nodes

This lab uses the Kubernetes **v1.36** package repository.

## Add Repository Key

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.36/deb/Release.key \
  | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
```

## Add Kubernetes Repository

```bash
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.36/deb/ /' \
  | sudo tee /etc/apt/sources.list.d/kubernetes.list
```

## Install Packages

```bash
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
```

The kubelet may restart/fail until kubeadm gives it cluster configuration. That is expected before `kubeadm init` or `kubeadm join`.

## Verify Versions

```bash
kubeadm version
kubelet --version
kubectl version --client
apt-mark showhold
```
