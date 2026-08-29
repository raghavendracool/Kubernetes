variable "aws_region" {
  description = "AWS region for EKS"
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "k8s-training-eks-tf"
}

variable "kubernetes_version" {
  description = "Kubernetes version for EKS"
  type        = string
  default     = "1.36"
}

variable "private_subnet_count" {
  description = "Number of private subnets to create in default VPC"
  type        = number
  default     = 2
}

variable "private_subnet_newbits" {
  description = "Additional subnet bits for cidrsubnet() from default VPC CIDR"
  type        = number
  default     = 4
}

variable "private_subnet_netnum_offset" {
  description = "Offset used to generate private subnet CIDRs from default VPC CIDR"
  type        = number
  default     = 8
}

variable "node_instance_types" {
  description = "EKS managed node group instance types"
  type        = list(string)
  default     = ["c7i-flex.large"]
}

variable "node_desired_size" {
  description = "Desired size of worker node group"
  type        = number
  default     = 2
}

variable "node_min_size" {
  description = "Minimum size of worker node group"
  type        = number
  default     = 2
}

variable "node_max_size" {
  description = "Maximum size of worker node group"
  type        = number
  default     = 4
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Project = "kubernetes-training"
    Owner   = "platform-team"
  }
}
