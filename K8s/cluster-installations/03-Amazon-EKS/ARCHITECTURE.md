# EKS Architecture

```text
IAM Identity
     ↓
EKS Access Entry / Authentication
     ↓
AWS-managed EKS Kubernetes API
     ↓
Customer VPC
 ┌──────────────┬──────────────┐
 ↓              ↓              ↓
Managed Node   Managed Node   Add-ons
EC2            EC2
 ↓              ↓
Pods           Pods
 ├── EBS CSI
 ├── Pod Identity
 └── AWS Load Balancer Controller
```
