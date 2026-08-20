# 9. AWS Load Balancer Controller — Complete Lab

The AWS Load Balancer Controller watches Kubernetes Service/Ingress resources and provisions/configures AWS ALB/NLB resources.

This lab uses **IRSA** for the controller because the official EKS installation flow provides an explicit, repeatable command sequence. EKS Pod Identity is also supported by the controller; do not attach the controller policy broadly to every worker node.

## Step 1 — Associate an IAM OIDC Provider

```bash
eksctl utils associate-iam-oidc-provider \
  --cluster "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --approve
```

Verify:

```bash
aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.identity.oidc.issuer' \
  --output text
```

## Step 2 — Download the Controller IAM Policy

The AWS EKS guide currently documents controller v2.14.1 for this installation flow:

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/install/iam_policy.json
```

Review before creating the policy:

```bash
python -m json.tool iam_policy.json >/dev/null && echo 'JSON valid'
less iam_policy.json
```

## Step 3 — Create IAM Policy

```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json
```

If the policy already exists, get its ARN:

```bash
LBC_POLICY_ARN=$(aws iam list-policies \
  --scope Local \
  --query "Policies[?PolicyName=='AWSLoadBalancerControllerIAMPolicy'].Arn | [0]" \
  --output text)

echo "$LBC_POLICY_ARN"
```

For a newly created policy you can also construct:

```bash
LBC_POLICY_ARN="arn:aws:iam::${ACCOUNT_ID}:policy/AWSLoadBalancerControllerIAMPolicy"
```

## Step 4 — Create IAM Role + Kubernetes ServiceAccount

```bash
eksctl create iamserviceaccount \
  --cluster "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --attach-policy-arn "$LBC_POLICY_ARN" \
  --override-existing-serviceaccounts \
  --approve
```

Verify:

```bash
kubectl get serviceaccount aws-load-balancer-controller -n kube-system -o yaml
```

## Step 5 — Add Helm Repository

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks
```

## Step 6 — Install Controller

```bash
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="$CLUSTER_NAME" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --version 1.14.0
```

If your nodes have restricted IMDS access, Fargate is used, or network discovery requires it, include region and VPC explicitly:

```bash
VPC_ID=$(aws eks describe-cluster \
  --name "$CLUSTER_NAME" \
  --region "$AWS_REGION" \
  --query 'cluster.resourcesVpcConfig.vpcId' \
  --output text)

helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="$CLUSTER_NAME" \
  --set region="$AWS_REGION" \
  --set vpcId="$VPC_ID" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --version 1.14.0
```

## Step 7 — Verify

```bash
kubectl get deployment aws-load-balancer-controller -n kube-system
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller
kubectl logs -n kube-system deployment/aws-load-balancer-controller --tail=100
```

Expected: controller Deployment available and Pods Running/Ready.

## Upgrade Note

The Helm chart does not automatically receive future security updates. Before upgrading the controller, review release notes. When using `helm upgrade`, install/update the CRDs as documented by the controller:

```bash
wget https://raw.githubusercontent.com/aws/eks-charts/master/stable/aws-load-balancer-controller/crds/crds.yaml
kubectl apply -f crds.yaml
```
