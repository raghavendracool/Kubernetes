# Kubernetes Learning Roadmap

```text
PHASE 1 — FOUNDATION
01 Why Kubernetes
02 Architecture
03 kubectl + YAML
04 Pods

PHASE 2 — APP MANAGEMENT
05 Deployments
06 Labels / Namespaces
07 Services / DNS
08 ConfigMaps / Secrets
09 Probes / Resources
10 Storage
11 Workload Controllers

PHASE 3 — PLATFORM CONTROL
12 Scheduling
13 RBAC
14 Networking
15 NetworkPolicies
16 Ingress / TLS
17 Autoscaling / Availability

PHASE 4 — DELIVERY & OPERATIONS
18 Helm
19 Troubleshooting / Observability
20 Security
21 Day-2 Operations

CLUSTERS
Minikube → kubeadm EC2 → Amazon EKS

FINAL
Production-style Kubernetes Mega Project
```

## Milestones

- Draw Kubernetes architecture from memory.
- Explain the `kubectl apply` request flow.
- Troubleshoot common Pod failures.
- Build a three-node kubeadm cluster.
- Implement least-privilege RBAC.
- Trace Pod/Service/DNS traffic.
- Deploy the same workload to EKS.
- Explain IAM/EKS access vs Kubernetes RBAC.
- Use EKS Pod Identity for workload AWS access.
