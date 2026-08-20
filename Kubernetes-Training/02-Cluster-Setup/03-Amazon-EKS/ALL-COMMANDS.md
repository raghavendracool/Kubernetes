# Amazon EKS — Command Runbook

```bash
export AWS_REGION=ap-south-1
export CLUSTER_NAME=k8s-training-eks

aws sts get-caller-identity

eksctl create cluster --name "$CLUSTER_NAME" --region "$AWS_REGION" --version 1.36 --managed --nodegroup-name app-ng --node-type t3.medium --nodes 2 --nodes-min 2 --nodes-max 4

aws eks update-kubeconfig --region "$AWS_REGION" --name "$CLUSTER_NAME"
kubectl get nodes -o wide
kubectl get pods -A -o wide

aws eks list-access-entries --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"
aws eks list-addons --cluster-name "$CLUSTER_NAME" --region "$AWS_REGION"

kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
kubectl top nodes

helm repo add eks https://aws.github.io/eks-charts
helm repo update

kubectl get events -A --sort-by=.lastTimestamp
```
