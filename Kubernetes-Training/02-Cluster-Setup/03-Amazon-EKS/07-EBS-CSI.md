# 7. EBS CSI Driver

The EBS CSI driver is required when EKS workloads use Amazon EBS-backed PersistentVolumes.

## Create a Pod Identity IAM Role

Create a trust policy file:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {"Service": "pods.eks.amazonaws.com"},
      "Action": ["sts:AssumeRole", "sts:TagSession"]
    }
  ]
}
```

```bash
aws iam create-role \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --assume-role-policy-document file://pod-identity-trust.json

aws iam attach-role-policy \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy
```

## Associate Role with EBS CSI ServiceAccount

```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws eks create-pod-identity-association \
  --cluster-name "$CLUSTER_NAME" \
  --namespace kube-system \
  --service-account ebs-csi-controller-sa \
  --role-arn "arn:aws:iam::${ACCOUNT_ID}:role/AmazonEKS_EBS_CSI_DriverRole" \
  --region "$AWS_REGION"
```

## Install EBS CSI Add-on

```bash
aws eks create-addon \
  --cluster-name "$CLUSTER_NAME" \
  --addon-name aws-ebs-csi-driver \
  --region "$AWS_REGION"
```

## Verify

```bash
kubectl get pods -n kube-system | grep ebs-csi
kubectl get csidrivers
kubectl get storageclass
```
