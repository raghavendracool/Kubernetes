# Local Quick Lab

Use this only for fast Kubernetes practice. The real administration track in this course is the kubeadm cluster in the next folder.

## Option A — kind

Prerequisites: Docker and kubectl.

For Windows and WSL setup, follow `README_install.md` in this same folder before creating the cluster.

```bash
kind create cluster --name k8s-training
kubectl cluster-info --context kind-k8s-training
kubectl get nodes -o wide
```

Create a 1-control-plane + 2-worker topology:

```yaml
# kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

```bash
kind delete cluster --name k8s-training
kind create cluster --name k8s-training --config kind-config.yaml
kubectl get nodes
```

Cleanup:

```bash
kind delete cluster --name k8s-training
```
