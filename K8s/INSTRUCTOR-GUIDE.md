# Instructor Guide

## Teaching Principle

For every topic:

```text
Problem → Why → Architecture → Demo → Student Lab → Break → Troubleshoot → Production → Interview
```

Do not start class by showing a large YAML file.

## Suggested Delivery

| Phase | Modules | Focus |
|---|---|---|
| Foundation | 01–04 | Why, architecture, YAML, Pods |
| App Operations | 05–11 | Deployments, Service, config, health, storage, controllers |
| Platform | 12–17 | Scheduling, RBAC, networking, policies, ingress, autoscaling |
| Operations | 18–21 | Helm, troubleshooting, security, Day-2 |
| Cluster Lab A | Minikube | local learning |
| Cluster Lab B | kubeadm EC2 | self-managed understanding |
| Cluster Lab C | EKS | AWS managed Kubernetes |
| Final | Mega Project | combine everything |

## Every Lab Must End With

1. `kubectl get`
2. `kubectl describe`
3. expected output discussion
4. one intentional failure
5. root-cause explanation
6. cleanup or next-module transition
