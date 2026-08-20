# 14. EKS Cleanup

Before deleting the cluster, delete Kubernetes resources that created external AWS load balancers so controllers have a chance to clean them up.

```bash
kubectl get ingress -A
kubectl get svc -A | grep LoadBalancer || true
```

Delete training namespaces/applications, then delete the cluster:

```bash
eksctl delete cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION"
```

Check for leftovers:

```bash
aws eks list-clusters --region "$AWS_REGION"
aws elbv2 describe-load-balancers --region "$AWS_REGION" --output table
aws ec2 describe-volumes --region "$AWS_REGION" --filters Name=status,Values=available --output table
```

Also review NAT Gateways, EBS volumes, load balancers and CloudWatch log groups for lab resources that may continue to incur cost.
