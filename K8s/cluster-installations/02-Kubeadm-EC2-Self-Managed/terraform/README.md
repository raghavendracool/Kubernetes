# Optional Terraform — Three EC2 Training Nodes

Creates three Ubuntu 24.04 nodes in the default VPC.

Before use:
1. set `student_cidr` to your public IPv4 `/32`;
2. set an existing EC2 key pair;
3. review costs/security group.

```bash
terraform init
terraform plan
terraform apply
```
