# Terraform EKS Track — Optional After Manual/eksctl Lab

Do not start Terraform until students can explain the EKS resources created manually. Terraform is the automation layer, not a replacement for Kubernetes understanding.

Recommended module boundaries:

```text
terraform/
  versions.tf
  providers.tf
  variables.tf
  vpc.tf
  eks.tf
  nodegroups.tf
  addons.tf
  outputs.tf
  terraform.tfvars.example
```

For production, use a maintained EKS module or carefully managed native resources, pin provider/module versions, use remote state and review plans before apply.
