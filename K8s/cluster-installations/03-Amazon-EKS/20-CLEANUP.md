# 20 — Cleanup

Delete application/LB resources first:

```bash
kubectl delete namespace student-app --ignore-not-found
```

Then:

```bash
eksctl delete cluster --name sdhub-k8s --region ap-south-1
```

Verify AWS account for leftover EC2, EBS, ELB, VPC/NAT, logs and IAM training resources.
