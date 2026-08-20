# Detailed Notes — Ingress, Gateway and TLS

## Complete Request Path

```text
DNS -> public/private IP -> Load Balancer/Ingress Controller
    -> Ingress/Gateway rule -> Kubernetes Service -> Ready Pod
```

Troubleshoot from outside inward. If DNS resolves to the wrong load balancer, Kubernetes Pod health is not the first problem.

## Ingress Resource vs Controller

The Ingress YAML contains routing intent. An NGINX Ingress Controller, AWS Load Balancer Controller or another controller watches that intent and creates/configures actual data-plane infrastructure.

## TLS

TLS needs a certificate whose names match the requested hostname, correct certificate chain/key configuration, and traffic reaching the TLS termination point.

## EKS Example

On EKS, the AWS Load Balancer Controller can translate supported Ingress configuration into an ALB. Its IAM permissions and subnet/network discovery are AWS-side dependencies in addition to Kubernetes configuration.
