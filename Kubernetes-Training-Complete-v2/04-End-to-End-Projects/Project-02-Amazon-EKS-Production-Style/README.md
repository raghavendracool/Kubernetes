# Project 02 — Amazon EKS Production-Style Deployment

## Objective

Create an EKS cluster, configure access/add-ons, deploy a multi-tier application, expose it using an AWS load balancer, add autoscaling and observability, then perform an operational validation.

## Recommended Production Architecture

```text
Internet / DNS
      |
      v
AWS ALB
      |
      v
Kubernetes frontend Service/Pods
      |
      v
Backend API Service/Pods
      |
      v
Amazon RDS PostgreSQL (production recommendation)

EKS managed control plane
Managed node group / chosen capacity layer
EBS CSI for block storage where required
Pod Identity for AWS permissions
CloudWatch + Prometheus-compatible monitoring
```

The bundled App 03 contains an in-cluster PostgreSQL StatefulSet for Kubernetes storage training. For the EKS production-style variant, the exercise is to replace that database with RDS and provide DB connectivity through Secrets/External Secrets or another approved secret mechanism.

## Phase 1 — EKS

Follow `02-Cluster-Setup/03-Amazon-EKS` through kubeconfig, access entries, add-ons, Pod Identity, Metrics Server and Load Balancer Controller.

## Phase 2 — Registry

Use ECR or another approved registry. Example ECR flow:

```bash
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
REGISTRY="${ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

aws ecr create-repository --repository-name store-api --region "$AWS_REGION" || true
aws ecr create-repository --repository-name store-web --region "$AWS_REGION" || true
aws ecr get-login-password --region "$AWS_REGION" | docker login --username AWS --password-stdin "$REGISTRY"
```

Build/tag/push application images.

## Phase 3 — Deploy Application

Deploy namespace, frontend and backend. Use either the bundled training PostgreSQL or your RDS variant.

## Phase 4 — Ingress/ALB

Create an Ingress that points to the frontend Service and uses your installed AWS Load Balancer Controller. Validate the generated ALB in both Kubernetes events and AWS ELBv2.

## Phase 5 — Resilience

Validate:

```bash
kubectl get hpa,pdb -n store
kubectl top pods -n store
kubectl delete pod <frontend-pod> -n store
kubectl get pods -n store -w
```

## Phase 6 — Operations

Capture:

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get ingress -A
kubectl get events -A --sort-by=.lastTimestamp
aws eks describe-cluster --name "$CLUSTER_NAME" --region "$AWS_REGION"
```

## Phase 7 — Cleanup

Delete Ingress/LoadBalancer-backed resources before deleting the cluster, then confirm no lab ALBs/EBS/NAT resources remain.
