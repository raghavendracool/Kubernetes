# Windows Minikube Setup

Recommended:
- Windows 10/11
- Docker Desktop
- PowerShell or Git Bash
- kubectl
- Minikube

Verify:

```powershell
docker --version
docker run --rm hello-world
```

Install approved current kubectl/Minikube packages. Where winget packages are available:

```powershell
winget install Kubernetes.kubectl
winget install Kubernetes.minikube
```

Start:

```powershell
minikube start --driver=docker --container-runtime=containerd --cpus=2 --memory=4096
```

Validate:

```powershell
minikube status
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -A
```
