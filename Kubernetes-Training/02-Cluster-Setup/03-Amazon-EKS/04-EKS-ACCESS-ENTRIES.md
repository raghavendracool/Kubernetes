# 4. EKS Access Entries

EKS access entries are the preferred AWS-native mechanism for granting IAM principals access to the Kubernetes API. They separate AWS identity mapping from Kubernetes workload identities.

## Inspect Authentication Mode

```bash
aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.accessConfig'
```

## List Access Entries

```bash
aws eks list-access-entries \
  --cluster-name "$CLUSTER_NAME" \
  --region "$AWS_REGION"
```

## Create Access Entry for an IAM Role

```bash
aws eks create-access-entry \
  --cluster-name "$CLUSTER_NAME" \
  --principal-arn arn:aws:iam::<ACCOUNT_ID>:role/<ROLE_NAME> \
  --type STANDARD \
  --region "$AWS_REGION"
```

Associate an AWS-managed EKS cluster access policy only after deciding the required scope. Do not grant cluster-admin automatically to every engineer.

## Kubernetes RBAC Alternative

An access entry can map an IAM identity to Kubernetes groups, and Kubernetes RoleBindings/ClusterRoleBindings then decide permissions. This is useful when you want fine-grained Kubernetes-native RBAC.
