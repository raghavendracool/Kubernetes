# EKS Demo App - 2048 Game

This is a proper web application demo for EKS training. It deploys a playable 2048 game and exposes it publicly through an AWS Load Balancer.

## What it Demonstrates

- Deployment with replicas
- Service type LoadBalancer for public website access
- Readiness and liveness probes
- HPA behavior (requires Metrics Server)
- Rollout and rollback

## Deploy

```bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-deployment.yaml
kubectl apply -f 02-service.yaml
kubectl apply -f 03-hpa.yaml
```

## Validate

```bash
kubectl get all -n eks-demo
kubectl get hpa -n eks-demo
kubectl get svc -n eks-demo
```

Wait for external endpoint:

```bash
kubectl get svc game-2048 -n eks-demo -w
```

When `EXTERNAL-IP` shows an AWS DNS name, open it in browser using `http://<external-dns>`.

## If External IP Is Pending

Check service events:

```bash
kubectl describe svc game-2048 -n eks-demo
```

Common reason: missing subnet tags for ELB.

Tag public subnets (replace cluster name if different):

```bash
export CLUSTER_NAME=k8s-training-eks-tf
VPC_ID=$(aws ec2 describe-vpcs --filters Name=isDefault,Values=true --query 'Vpcs[0].VpcId' --output text)

for s in $(aws ec2 describe-subnets --filters Name=vpc-id,Values=$VPC_ID Name=map-public-ip-on-launch,Values=true --query 'Subnets[].SubnetId' --output text); do
	aws ec2 create-tags --resources $s --tags Key=kubernetes.io/role/elb,Value=1 Key=kubernetes.io/cluster/$CLUSTER_NAME,Value=shared
done
```

Re-check:

```bash
kubectl get svc game-2048 -n eks-demo -w
```

## Rollout Demo

Use a different image tag to demonstrate rollout/undo:

```bash
kubectl set image deployment/game-2048 game-2048=public.ecr.aws/l6m2t8p7/docker-2048:latest -n eks-demo
kubectl rollout status deployment/game-2048 -n eks-demo
kubectl rollout history deployment/game-2048 -n eks-demo
kubectl rollout undo deployment/game-2048 -n eks-demo
```

## Cleanup

```bash
kubectl delete namespace eks-demo
```
