# Amazon EKS — Managed Kubernetes Track

This track starts only after students understand the kubeadm cluster. The goal is to identify what AWS manages for you and what still remains your responsibility.

## Responsibility Split

```text
AWS manages:
- Kubernetes control plane availability
- control-plane infrastructure lifecycle
- managed API endpoint integration

You still manage:
- worker capacity / node groups / Auto Mode choice
- Kubernetes workloads and namespaces
- RBAC / EKS access
- add-ons and their compatibility
- networking design and security
- ingress/load balancing
- storage drivers and workload data
- monitoring, cost and upgrades
```

## Build Order

1. prerequisites
2. VPC/network design
3. create EKS 1.36 cluster
4. kubeconfig and validation
5. managed node groups
6. access entries
7. EKS add-ons
8. Pod Identity
9. EBS CSI
10. Metrics Server
11. AWS Load Balancer Controller
12. observability
13. scaling
14. security
15. upgrades
16. cleanup
