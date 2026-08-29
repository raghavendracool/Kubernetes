variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "vpc_id" {
  type        = string
  description = "VPC id for cluster"
}

variable "private_subnet_ids" {
  type        = list(string)
  description = "Private subnet ids for EKS cluster and node groups"
}

variable "node_instance_types" {
  type        = list(string)
  description = "Managed node group instance types"
}

variable "node_desired_size" {
  type        = number
  description = "Desired node count"
}

variable "node_min_size" {
  type        = number
  description = "Minimum node count"
}

variable "node_max_size" {
  type        = number
  description = "Maximum node count"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
}
