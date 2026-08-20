# START HERE

## Prerequisites

- Linux basics
- Git/GitHub
- IP, subnet, DNS, port and HTTP basics
- Docker images and containers
- Basic AWS before the EKS section

Verify:

```bash
git --version
docker --version
kubectl version --client
```

AWS track:

```bash
aws --version
eksctl version
helm version
```

## Student Rule

For every Kubernetes object ask:

1. Why does it exist?
2. What problem does it solve?
3. Which component uses it?
4. How do I validate it?
5. How can it fail?
6. How do I troubleshoot it?

## Recommended Order

```text
Modules 01–02
   ↓
Minikube installation
   ↓
Modules 03–13
   ↓
kubeadm EC2 installation
   ↓
Modules 14–21
   ↓
Amazon EKS
   ↓
Mega Project
```

## AWS Cost Warning

Training AWS resources cost money. Use a non-production account, restrict access, tag resources and complete cleanup.
