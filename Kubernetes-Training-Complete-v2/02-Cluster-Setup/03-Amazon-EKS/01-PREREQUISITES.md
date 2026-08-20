# 1. EKS Prerequisites

## Check local tools

```bash
aws --version
kubectl version --client
eksctl version
helm version
```

## Verify AWS identity and region

```bash
aws sts get-caller-identity
aws configure get region
```

For this training runbook examples use:

```bash
export AWS_REGION=ap-south-1
export CLUSTER_NAME=k8s-training-eks
```

## Confirm EKS Kubernetes Versions Available

Do not assume a version. Check your region/account:

```bash
aws eks describe-cluster-versions --region "$AWS_REGION" 2>/dev/null || true
```

If that command is unavailable in your AWS CLI version, use the EKS console/documentation and upgrade AWS CLI. This course baseline is Kubernetes 1.36.
