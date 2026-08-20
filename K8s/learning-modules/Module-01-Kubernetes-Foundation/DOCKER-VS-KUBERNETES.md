# Docker vs Kubernetes

| Docker Concept | Kubernetes Equivalent / Relationship |
|---|---|
| Container | Runs inside a Pod |
| `docker run` | Pod / Deployment |
| `docker ps` | `kubectl get pods` |
| `docker logs` | `kubectl logs` |
| `docker exec` | `kubectl exec` |
| Docker image | Same container image is consumed by Kubernetes |
| Docker Compose | Multiple Kubernetes objects such as Deployment, Service, ConfigMap |
| Docker network | Pod networking/CNI + Service networking |
| Docker volume | Kubernetes Volume / PV / PVC |
| Published port | Service / Ingress |
| Manual scale | Deployment / HPA |

## Key Learning Sentence

**Docker helps package and run containers. Kubernetes orchestrates containerized workloads across a cluster.**
