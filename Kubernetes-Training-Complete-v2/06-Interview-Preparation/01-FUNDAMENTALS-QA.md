# Kubernetes Interview — Fundamentals

## 1. What is a Pod?
A Pod is the smallest normal deployable Kubernetes unit. It contains one or more containers that share the Pod network namespace and can share volumes.

## 2. Deployment vs StatefulSet?
A Deployment is normally used for interchangeable stateless replicas. StatefulSet is used when stable identity, ordered lifecycle or per-replica persistent storage matters.

## 3. Service vs Ingress?
A Service provides stable in-cluster access to selected Pods. Ingress defines HTTP/HTTPS routing from outside toward Services and requires an Ingress controller.

## 4. Readiness vs liveness?
Readiness decides whether a Pod should receive traffic. Liveness decides whether a failing container should be restarted. Startup probe protects slow-starting applications.

## 5. Requests vs limits?
Requests are used by the scheduler for placement and are a baseline for resource planning/HPA calculations. Limits cap resource usage according to resource behavior.

## 6. Why can a Pod remain Pending?
Insufficient CPU/memory, taints, affinity rules, missing PVC capacity, topology constraints or other scheduler requirements can prevent assignment.

## 7. What happens after `kubectl apply`?
Request reaches API server, is authenticated/authorized/admitted, desired state is stored, controllers reconcile, scheduler chooses nodes for Pods, kubelet and runtime create containers, CNI provides networking, and status is reported back.
