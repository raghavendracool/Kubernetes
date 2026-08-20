# 2. Create EKS Cluster with eksctl

## Simple Training Cluster

```bash
export AWS_REGION=ap-south-1
export CLUSTER_NAME=k8s-training-eks

aws sts get-caller-identity

eksctl create cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --version 1.36 \
  --managed \
  --nodegroup-name app-ng \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 2 \
  --nodes-max 4
```

## Why start with eksctl?

For teaching, `eksctl` exposes the cluster concepts while avoiding dozens of low-level IAM/VPC CLI calls. After students understand the objects, Terraform can be introduced as the repeatable infrastructure path.

## Validate AWS-side cluster state

```bash
aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.{Status:status,Version:version,Endpoint:endpoint,Platform:platformVersion}' \
  --output table
```
