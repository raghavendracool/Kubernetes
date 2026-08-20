variable "region" {
  type = string
  default = "ap-south-1"
}
variable "student_cidr" {
  type = string
  description = "Your public IPv4 CIDR, e.g. 203.0.113.10/32"
}
variable "key_name" { type = string }
variable "instance_type" {
  type = string
  default = "t3.medium"
}
