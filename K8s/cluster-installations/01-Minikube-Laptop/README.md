# Installation 01 — Minikube on Laptop

## Goal

Create a local Kubernetes cluster without cloud cost.

## Architecture

```text
Laptop
  ├── Docker Desktop / Docker Engine
  ├── kubectl
  └── Minikube
        └── Kubernetes node
             ├── control-plane components
             ├── kubelet/runtime
             └── Pods
```

## Sequence

1. Install Docker.
2. Install kubectl.
3. Install Minikube.
4. Start cluster.
5. Validate.
6. Enable metrics-server.
7. Enable ingress.
8. Deploy first app.
9. Test self-healing.
10. Cleanup.
