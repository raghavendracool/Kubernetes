variable "cluster_name" {
  type        = string
  description = "EKS cluster name used for subnet tagging"
}

variable "default_vpc_id" {
  type        = string
  description = "Default VPC id"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet ids used to place NAT gateway"
}

variable "private_subnet_azs" {
  type        = list(string)
  description = "Availability zones where private subnets are created"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
}
