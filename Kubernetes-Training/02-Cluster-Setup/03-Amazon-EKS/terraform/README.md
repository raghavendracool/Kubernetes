# Terraform EKS Track - Student Execution Runbook

Use this runbook exactly in order during training.

## 1. What You Will Build

This lab creates:

- EKS cluster in the default VPC of your AWS region
- New private subnets derived from default VPC CIDR
- One NAT Gateway for private subnet egress
- Managed node group in private subnets
- IAM roles and policies for cluster and nodes
- Demo app exposed through Service type LoadBalancer

## 2. Prerequisites on Laptop

Install and configure:

- Terraform 1.6 or later
- AWS CLI v2
- kubectl

Confirm tools:

```bash
terraform -v
aws --version
kubectl version --client
```

Configure AWS credentials if not done:

```bash
aws configure
```

## 3. Verify AWS Account and Default VPC

Run:

```bash
aws sts get-caller-identity
aws configure get region
aws ec2 describe-vpcs --filters Name=isDefault,Values=true --query "Vpcs[].{VpcId:VpcId,CidrBlock:CidrBlock,State:State}" --output table
```

Expected:

- Account and IAM identity should be correct
- Region should be the one you want for class
- Default VPC should exist and be available

## 4. Move to Terraform Folder

```bash
cd 02-Cluster-Setup/03-Amazon-EKS/terraform
```

## 5. Prepare Variables

Create variable file:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Review values in terraform.tfvars.

Defaults used in this repo:

- aws_region = us-east-1
- cluster_name = k8s-training-eks-tf
- kubernetes_version = 1.36
- node instance = t3.medium

## 6. Terraform Init and Validate

```bash
terraform init
terraform fmt
terraform validate
```

## 7. Plan and Apply

```bash
terraform plan -out tfplan
terraform apply tfplan
```

Note:

- First apply can take 15-25 minutes.

## 8. IAM Roles and Policies Created

This setup explicitly creates:

- k8s-training-eks-tf-cluster-role
- k8s-training-eks-tf-node-role

Verify roles:

```bash
aws iam get-role --role-name k8s-training-eks-tf-cluster-role
aws iam get-role --role-name k8s-training-eks-tf-node-role
```

Verify attached policies:

```bash
aws iam list-attached-role-policies --role-name k8s-training-eks-tf-cluster-role
aws iam list-attached-role-policies --role-name k8s-training-eks-tf-node-role
```

## 9. Configure kubectl for New Cluster

```bash
aws eks update-kubeconfig --region us-east-1 --name k8s-training-eks-tf
kubectl get nodes -o wide
```

Expected:

- Worker nodes become Ready

## 10. Deploy Demo Application

Go to demo app folder:

```bash
cd ../demo-app
```

Apply manifests:

```bash
kubectl apply -f 00-namespace.yaml
kubectl apply -f 01-deployment.yaml
kubectl apply -f 02-service.yaml
kubectl apply -f 03-hpa.yaml
```

Verify:

```bash
kubectl get all -n eks-demo
kubectl get hpa -n eks-demo
kubectl get svc -n eks-demo
```

Wait for external endpoint:

```bash
kubectl get svc podinfo -n eks-demo -w
```

Open the external hostname from EXTERNAL-IP column in browser.

## 11. Classroom Demo Commands

Watch pods and nodes:

```bash
kubectl get pods -n eks-demo -o wide -w
```

Rollout demo:

```bash
kubectl set image deployment/podinfo podinfo=ghcr.io/stefanprodan/podinfo:6.6.3 -n eks-demo
kubectl rollout status deployment/podinfo -n eks-demo
kubectl rollout history deployment/podinfo -n eks-demo
kubectl rollout undo deployment/podinfo -n eks-demo
```

## 12. Key Pair Requirement

No EC2 key pair is required for this setup.

- EKS managed node groups can run without SSH key pair.
- Node role includes AmazonSSMManagedInstanceCore for SSM-based troubleshooting.

## 13. Common Troubleshooting

If terraform plan fails:

- Confirm aws configure region
- Confirm IAM permissions

If nodes are not Ready:

- Check EKS node group status in AWS console
- Check aws-auth access and cluster events

If LoadBalancer EXTERNAL-IP is pending:

- Wait a few minutes
- Check public subnet tags and VPC quotas

## 14. Cleanup After Class

Delete app:

```bash
kubectl delete namespace eks-demo
```

Destroy infrastructure:

```bash
cd ../terraform
terraform destroy
```

## 15. Folder Structure

```text
terraform/
  versions.tf
  providers.tf
  variables.tf
  data.tf
  locals.tf
  main.tf
  outputs.tf
  terraform.tfvars.example
  modules/
    network/
      main.tf
      variables.tf
      outputs.tf
    eks/
      main.tf
      variables.tf
      outputs.tf
```
