# 13. EKS Upgrade Runbook

## 1. Record current versions

```bash
aws eks describe-cluster --name "$CLUSTER_NAME" --region "$AWS_REGION" --query 'cluster.{Version:version,Platform:platformVersion}'
aws eks list-addons --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
kubectl get nodes -o wide
```

## 2. Check upgrade insights / deprecated APIs

Review EKS upgrade insights and application API compatibility before changing the cluster version.

## 3. Upgrade control plane

Upgrade one supported minor-version step at a time following current EKS rules and your change process.

## 4. Update add-ons

For each add-on, inspect versions compatible with the target Kubernetes version:

```bash
aws eks describe-addon-versions --kubernetes-version <TARGET_VERSION> --region "$AWS_REGION"
```

## 5. Update node groups

```bash
eksctl upgrade nodegroup --cluster "$CLUSTER_NAME" --name app-ng --region "$AWS_REGION"
```

## 6. Validate workloads

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp
```
