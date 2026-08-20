# 10 — EKS Pod Identity

```text
Pod
 ↓
ServiceAccount
 ↓
EKS Pod Identity Association
 ↓
IAM Role
 ↓
AWS API
```

Check Pod Identity Agent:

```bash
aws eks describe-addon   --cluster-name sdhub-k8s   --addon-name eks-pod-identity-agent   --region ap-south-1
```

Example ServiceAccount:

```yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: s3-reader
  namespace: student-app
```

Create association after creating the correctly trusted IAM role:

```bash
aws eks create-pod-identity-association   --cluster-name sdhub-k8s   --namespace student-app   --service-account s3-reader   --role-arn arn:aws:iam::<ACCOUNT_ID>:role/StudentS3ReaderRole   --region ap-south-1
```

Validate in a Pod that uses that ServiceAccount:

```bash
aws sts get-caller-identity
```

Grant only the AWS permissions required by the lab.
