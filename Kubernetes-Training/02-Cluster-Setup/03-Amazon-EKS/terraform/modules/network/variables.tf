variable "cluster_name" {
  type        = string
  description = "EKS cluster name used for subnet tagging"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR for dedicated VPC"
}

variable "subnet_azs" {
  type        = list(string)
  description = "Availability zones for subnet creation"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
}

variable "tags" {
  type        = map(string)
  description = "Common tags"
}
