# Version Matrix

| Component | Course Baseline |
|---|---|
| Kubernetes | 1.36 |
| kubeadm / kubelet / kubectl | 1.36.x |
| Ubuntu | 24.04 LTS |
| Runtime | containerd |
| Calico | 3.32.x |
| Amazon EKS | Kubernetes 1.36 |
| AWS example region | ap-south-1 |
| Helm | 3.x |
| Minikube | current stable |
| eksctl | current stable |

## Rules

- Check official docs before each new batch.
- Kubernetes package repositories are minor-version specific.
- Do not skip minor versions during kubeadm upgrades.
- Check EKS add-on compatibility before upgrades.
