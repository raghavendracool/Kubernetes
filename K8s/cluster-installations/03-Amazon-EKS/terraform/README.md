# Terraform Follow-On for EKS

First build EKS with eksctl so students understand the platform without hiding it behind IaC.

After the EKS concepts are clear, create a separate Terraform implementation with:

```text
versions.tf
providers.tf
variables.tf
vpc.tf
eks.tf
nodegroups.tf
access.tf
addons.tf
outputs.tf
environments/dev.tfvars
environments/qa.tfvars
environments/prod.tfvars
```

The Kubernetes course should teach the resources first; Terraform automation comes after understanding.
