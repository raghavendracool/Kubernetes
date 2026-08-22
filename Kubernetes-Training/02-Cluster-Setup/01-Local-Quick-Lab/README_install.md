# Kubernetes Local Setup on Windows Laptop using WSL2, Docker Desktop and kind

> **Goal:** Build a local 3-node Kubernetes cluster on a Windows laptop using **WSL2 + Ubuntu + Docker Desktop + kubectl + kind**.

---

## 1. Architecture

```text
Windows Laptop
      |
      v
    WSL2
      |
      v
   Ubuntu
      |
      v
Docker Desktop
      |
      v
    kind
      |
      v
+----------------------------+
| Control Plane              |
| Worker 1                   |
| Worker 2                   |
+----------------------------+
```

> In this local lab, all Kubernetes nodes run as Docker containers on the same laptop.

---

## 2. Check WSL from PowerShell

Open **PowerShell as Administrator**.

```powershell
wsl -l -v
```

Expected:

```text
NAME              STATE      VERSION
Ubuntu            Running    2
docker-desktop    Running    2
```

If Ubuntu already exists, **do not run `wsl --install` again**.

Update WSL:

```powershell
wsl --update
```

Set WSL2 as default:

```powershell
wsl --set-default-version 2
```

---

## 3. Start Docker Desktop

Open **Docker Desktop** and wait until it shows:

```text
Engine running
```

Docker Desktop must be running before creating the kind cluster.

---

## 4. Connect to Ubuntu WSL

From PowerShell:

```powershell
wsl -d Ubuntu
```

Your prompt should change from:

```text
PS C:\WINDOWS\System32>
```

to something similar to:

```text
raghavendrarao@HYD-PF48CRR5:~$
```

This confirms that you are inside Ubuntu WSL.

---

## 5. Move to Ubuntu Home Directory

Do not work inside:

```text
/mnt/c/WINDOWS/System32
```

Run:

```bash
cd ~
pwd
```

Expected:

```text
/home/<username>
```

---

## 6. Verify Ubuntu

```bash
whoami
cat /etc/os-release
uname -a
```

---

## 7. Verify Docker from Ubuntu

```bash
docker version
```

You should see both a Docker **Client** and **Server: Docker Desktop** section.

Check containers:

```bash
docker ps
```

Test Docker:

```bash
docker run --rm hello-world
```

Expected:

```text
Hello from Docker!
```

If this works, Ubuntu WSL can successfully communicate with Docker Desktop.

---

## 8. Verify kubectl

```bash
cd ~
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client
kubectl version --client
```

Example:

```text
Client Version: v1.34.1
```

---

## 9. Install kind

Update packages:

```bash
sudo apt update
```

Install kind:

```bash
sudo apt install kind -y
```

Verify:

```bash
kind version
```

Example:

```text
kind v0.30.0
```

---

## 10. Create the Lab Directory

```bash
mkdir -p ~/k8s-lab
cd ~/k8s-lab
pwd
```

Expected:

```text
/home/<username>/k8s-lab
```

---

## 11. Create `kind-config.yaml`

```bash
cat > kind-config.yaml <<'YAML'
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4

nodes:
  - role: control-plane
  - role: worker
  - role: worker
YAML
```

Verify the file:

```bash
cat kind-config.yaml
```

Expected:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4

nodes:
  - role: control-plane
  - role: worker
  - role: worker
```

---

## 12. Create the Kubernetes Cluster

```bash
kind create cluster --name k8s-training --config kind-config.yaml
```

kind will perform roughly this sequence:

```text
Ensuring node image
        ↓
Preparing nodes
        ↓
Writing configuration
        ↓
Starting control-plane
        ↓
Installing CNI
        ↓
Installing StorageClass
        ↓
Joining worker nodes
        ↓
Cluster Ready
```

Expected final message:

```text
Set kubectl context to "kind-k8s-training"
```

---

## 13. Check Node Status

Immediately after creation:

```bash
kubectl get nodes
```

You may briefly see `NotReady`. This is normal while CNI, CoreDNS, kube-proxy and other components start.

Wait 30 seconds to 2 minutes and run again:

```bash
kubectl get nodes
```

Expected:

```text
NAME                         STATUS   ROLES
k8s-training-control-plane   Ready    control-plane
k8s-training-worker          Ready    <none>
k8s-training-worker2         Ready    <none>
```

Detailed view:

```bash
kubectl get nodes -o wide
```

---

## 14. Check Kubernetes System Pods

```bash
kubectl get pods -A
```

You should see components such as:

```text
coredns
etcd
kindnet
kube-apiserver
kube-controller-manager
kube-proxy
kube-scheduler
local-path-provisioner
```

They should eventually show `Running`.

---

## 15. Why Does `kubectl get pods` Show Nothing?

If you run:

```bash
kubectl get pods
```

and receive:

```text
No resources found in default namespace.
```

this is **not an error**.

It means no application Pods have been created in the `default` namespace yet.

To see system Pods:

```bash
kubectl get pods -A
```

---

## 16. Verify Kubernetes Context

```bash
kubectl config current-context
```

Expected:

```text
kind-k8s-training
```

List all contexts:

```bash
kubectl config get-contexts
```

If required, switch back to the local cluster:

```bash
kubectl config use-context kind-k8s-training
```

---

## 17. Verify Cluster Information

```bash
kubectl cluster-info
```

Or explicitly:

```bash
kubectl cluster-info --context kind-k8s-training
```

---

## 18. Verify kind Cluster and Nodes

```bash
kind get clusters
```

Expected:

```text
k8s-training
```

Check nodes created by kind:

```bash
kind get nodes --name k8s-training
```

Expected:

```text
k8s-training-control-plane
k8s-training-worker
k8s-training-worker2
```

---

## 19. Verify Kubernetes Nodes as Docker Containers

```bash
docker ps --format "table {{.Names}}\t{{.Status}}"
```

You should see:

```text
k8s-training-control-plane
k8s-training-worker
k8s-training-worker2
```

For this local lab:

```text
Docker Container = Kubernetes Node
```

---

## 20. Final Verification

Run:

```bash
docker version
kind version
kubectl version --client
kind get clusters
kubectl config current-context
kubectl cluster-info
kubectl get nodes
kubectl get nodes -o wide
kubectl get pods -A
docker ps --format "table {{.Names}}\t{{.Status}}"
```

Expected final status:

```text
WSL2                    ✅
Ubuntu                   ✅
Docker Desktop           ✅
Docker connection        ✅
kubectl                  ✅
kind                     ✅
Kubernetes Cluster       ✅
Control Plane            ✅ Ready
Worker 1                 ✅ Ready
Worker 2                 ✅ Ready
CoreDNS                  ✅ Running
CNI                      ✅ Running
Storage Provisioner      ✅ Running
```

---

## 21. Delete the Cluster

When you want to remove the local cluster:

```bash
kind delete cluster --name k8s-training
```

Verify:

```bash
kind get clusters
```

---

## 22. Recreate the Cluster

```bash
cd ~/k8s-lab
cat kind-config.yaml
kind create cluster --name k8s-training --config kind-config.yaml
```

Verify:

```bash
kubectl get nodes
kubectl get pods -A
```

---

# Quick Setup — Commands Only

## PowerShell

```powershell
wsl -l -v
wsl --update
wsl --set-default-version 2
wsl -d Ubuntu
```

## Ubuntu WSL

```bash
cd ~
docker version
docker ps
kubectl version --client
sudo apt update
sudo apt install kind -y
kind version
mkdir -p ~/k8s-lab
cd ~/k8s-lab
```

Create the config:

```bash
cat > kind-config.yaml <<'YAML'
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
YAML
```

Create the cluster:

```bash
kind create cluster --name k8s-training --config kind-config.yaml
```

Validate:

```bash
kubectl get nodes
kubectl get pods -A
kubectl cluster-info
kubectl config current-context
kind get clusters
docker ps
```

---

# Local Setup Complete ✅

The local Kubernetes lab is complete when:

```bash
kubectl get nodes
```

shows all three nodes as `Ready`, and:

```bash
kubectl get pods -A
```

shows the Kubernetes system Pods running.

Your laptop is now ready for Kubernetes hands-on practice.
