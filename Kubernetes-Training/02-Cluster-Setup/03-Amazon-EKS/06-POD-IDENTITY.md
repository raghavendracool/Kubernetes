# 6. EKS Pod Identity

EKS Pod Identity lets a Kubernetes ServiceAccount obtain AWS permissions through an IAM role without placing static AWS keys in Pods.

## Install Pod Identity Agent Add-on

```bash
aws eks create-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name eks-pod-identity-agent \
  --region "$AWS_REGION"
```

If it already exists, inspect it instead:

```bash
aws eks describe-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name eks-pod-identity-agent \
  --region "$AWS_REGION"
```

## Verify Agent

```bash
kubectl get pods -n kube-system | grep pod-identity
```

## Pod Identity Flow

```text
Pod
  ↓ uses ServiceAccount
EKS Pod Identity Agent
  ↓ association
IAM Role
  ↓ temporary credentials
AWS API
```

Use one IAM role per workload responsibility where practical. Do not attach broad application permissions to every node role.
