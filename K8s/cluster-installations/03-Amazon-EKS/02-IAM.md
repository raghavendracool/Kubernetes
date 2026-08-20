# 02 — IAM Mental Model

Human access:

```text
IAM Role/User
  ↓
EKS authentication/access entry
  ↓
EKS access policy OR Kubernetes group
  ↓
Kubernetes authorization
```

Workload AWS access:

```text
Pod → ServiceAccount → EKS Pod Identity → IAM Role → AWS Service
```

Never solve this by embedding long-lived AWS keys in Pods.
