# 3. kubeconfig and Validation

```bash
aws eks update-kubeconfig \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME"

kubectl config current-context
kubectl cluster-info
kubectl get nodes -o wide
kubectl get pods -A -o wide
```

## Verify EKS Control Plane

```bash
aws eks describe-cluster \
  --region "$AWS_REGION" \
  --name "$CLUSTER_NAME" \
  --query 'cluster.{Name:name,Version:version,Status:status,Endpoint:endpoint,Auth:accessConfig.authenticationMode}' \
  --output yaml
```

## Verify Node Groups

```bash
aws eks list-nodegroups --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
eksctl get nodegroup --cluster "$CLUSTER_NAME" --region "$AWS_REGION"
```
