# Kubernetes for DevOps Engineers — Complete Hands-On Training

This repository is designed as a **teaching book + lab repository**. It intentionally keeps three things separate:

1. **Learning modules** — Kubernetes concepts, commands, YAML, verification and troubleshooting.
2. **Cluster setup tracks** — local lab, self-managed kubeadm cluster on EC2 (on-prem style), and Amazon EKS.
3. **Applications** — source code and deployment manifests live in their own folders and are not mixed into concept modules.

## Recommended Learning Order

```text
Docker basics
   ↓
01-Learning-Modules (concepts + kubectl + YAML)
   ↓
02-Cluster-Setup/02-Kubeadm-EC2-OnPrem-Style
   ↓
03-Applications (deploy real applications)
   ↓
02-Cluster-Setup/03-Amazon-EKS
   ↓
04-End-to-End-Projects
   ↓
Operations + Security + Interview Preparation
```

## What Every Module Contains

Every learning module follows the same classroom-friendly format:

- `README.md` — What, Why, Where, architecture, detailed explanation, examples.
- `COMMANDS.md` — commands grouped by task with explanations.
- `LAB.md` — hands-on exercise, validation, expected result and cleanup.
- `examples/` — YAML used only to demonstrate that module's concept.

## Version Baseline — August 2026

- Kubernetes upstream training baseline: **v1.36**.
- Amazon EKS lab baseline: **Kubernetes 1.36**.
- Self-managed kubeadm lab: **Kubernetes 1.36** on Ubuntu 24.04 LTS.
- Container runtime: **containerd**.
- Calico lab baseline: **v3.32.1**.
- Helm examples use commands that work with current Helm releases.

> Kubernetes moves quickly. For production, always verify the currently supported Kubernetes/EKS and add-on versions before upgrading.

## Folder Map

| Folder | Purpose |
|---|---|
| `00-Course-Guide` | roadmap, prerequisites, lab rules, version notes |
| `01-Learning-Modules` | Kubernetes concepts from beginner to production operations |
| `02-Cluster-Setup` | local, kubeadm/EC2, Amazon EKS |
| `03-Applications` | independent application source code + Kubernetes manifests |
| `04-End-to-End-Projects` | complete on-prem-style and EKS deployment projects |
| `05-Cheat-Sheets` | kubectl, YAML, troubleshooting, networking, RBAC |
| `06-Interview-Preparation` | scenario and interview questions |
| `scripts` | validation and utility scripts |

## Student Rule

Do not only copy commands. For each command, explain:

```text
What am I doing?
Why am I doing it?
What Kubernetes object/component changes?
How do I verify it?
How do I troubleshoot it if it fails?
```
