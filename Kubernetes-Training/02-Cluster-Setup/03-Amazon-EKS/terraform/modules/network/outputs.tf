output "vpc_id" {
  value       = aws_vpc.this.id
  description = "Dedicated VPC ID"
}

output "public_subnet_ids" {
  value       = [for s in aws_subnet.public : s.id]
  description = "Public subnet IDs"
}

output "private_subnet_ids" {
  value       = [for s in aws_subnet.private : s.id]
  description = "Private subnet IDs"
}

output "private_subnet_cidrs" {
  value       = [for s in aws_subnet.private : s.cidr_block]
  description = "Private subnet CIDRs"
}

output "nat_gateway_id" {
  value       = aws_nat_gateway.this.id
  description = "NAT gateway id for private subnet egress"
}
