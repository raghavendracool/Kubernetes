# ☸️ Kubernetes for DevOps — Zero to Production

A practical Kubernetes training repository for DevOps students.

> Modules 01–21 are interlinked. Students first understand *why Kubernetes exists*, then evolve one application through Pods, Deployments, Services, configuration, health, RBAC, networking, Ingress, autoscaling, Helm, security and Day-2 operations.

## What Makes This Repository Different

```text
What is the concept?
        ↓
The 3 Whys
        ↓
Problem before this concept
        ↓
Architecture / easy analogy
        ↓
How it works internally
        ↓
Hands-on practical
        ↓
Command-by-command learning
        ↓
Validation
        ↓
Break it intentionally
        ↓
Troubleshooting
        ↓
Production best practices
        ↓
Interview questions
        ↓
Student assignment
```

## Three Cluster Tracks

1. **Minikube on Laptop**
2. **Self-Managed Kubernetes with kubeadm on EC2** — on-premises style simulation
3. **Amazon EKS** — managed Kubernetes on AWS

## Learning Modules

| # | Topic |
|---:|---|
| 01 | Kubernetes Foundation — 3 Whys + Docker vs Kubernetes |
| 02 | Kubernetes Architecture |
| 03 | kubectl, YAML & First Pod |
| 04 | Pods |
| 05 | ReplicaSets & Deployments |
| 06 | Labels, Selectors & Namespaces |
| 07 | Services & DNS |
| 08 | ConfigMaps & Secrets |
| 09 | Probes, Resources & QoS |
| 10 | Storage |
| 11 | Workload Controllers |
| 12 | Scheduling |
| 13 | ServiceAccounts & RBAC |
| 14 | Kubernetes Networking |
| 15 | NetworkPolicies |
| 16 | Ingress & TLS |
| 17 | Autoscaling & Availability |
| 18 | Helm |
| 19 | Monitoring, Logging & Troubleshooting |
| 20 | Kubernetes Security |
| 21 | Day-2 Operations |

## Progressive Execution Folder

When a module contains a `stage/` snapshot:

```bash
bash scripts/load-module.sh 5
cd kubernetes-live/manifests
kubectl apply -f .
```

PowerShell:

```powershell
.\scripts\Load-Module.ps1 -Module 5
cd kubernetes-live\manifests
kubectl apply -f .
```

## Current Baseline

See [VERSION-MATRIX.md](VERSION-MATRIX.md).

## Start

Read [START-HERE.md](START-HERE.md).
