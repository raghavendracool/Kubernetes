# Self-Managed Kubernetes with kubeadm on EC2 — On-Prem Style

This track teaches the work AWS normally hides when you use EKS. EC2 is used only as the Linux server platform; Kubernetes itself is installed and managed with **kubeadm**, like a traditional self-managed/on-premises cluster.

## Target Architecture

```text
                         Admin workstation
                        kubectl / SSH access
                                |
                                v
+----------------------------------------------------------------+
|                 AWS VPC used as server network                  |
|                                                                |
|  Control Plane EC2                                             |
|  k8s-cp-01  (Ubuntu 24.04, t3.medium)                          |
|  - kube-apiserver                                              |
|  - kube-controller-manager                                     |
|  - kube-scheduler                                              |
|  - etcd                                                        |
|                                                                |
|  Worker EC2 #1                 Worker EC2 #2                    |
|  k8s-worker-01                 k8s-worker-02                    |
|  - kubelet                     - kubelet                        |
|  - containerd                  - containerd                     |
|  - Calico CNI                  - Calico CNI                     |
+----------------------------------------------------------------+
```

## Build Order

1. `01-ARCHITECTURE-AND-EC2.md`
2. `02-NETWORK-AND-SECURITY.md`
3. `03-PREPARE-UBUNTU-ALL-NODES.md`
4. `04-INSTALL-CONTAINERD.md`
5. `05-INSTALL-KUBERNETES-PACKAGES.md`
6. `06-INITIALIZE-CONTROL-PLANE.md`
7. `07-INSTALL-CALICO-CNI.md`
8. `08-JOIN-WORKERS.md`
9. `09-VALIDATE-CLUSTER.md`
10. `10-ADMIN-KUBECONFIG.md`
11. `11-TROUBLESHOOTING.md`
12. `12-RESET-AND-CLEANUP.md`

## Important Training Point

A kubeadm cluster is **not** an EKS cluster. You own control-plane lifecycle, etcd, OS patching, Kubernetes upgrades, CNI operations and node recovery. That difference is one of the main reasons to learn this track before EKS.
