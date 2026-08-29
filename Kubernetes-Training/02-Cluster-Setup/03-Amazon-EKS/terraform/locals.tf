locals {
  selected_azs = slice(
    data.aws_availability_zones.available.names,
    0,
    min(var.private_subnet_count, length(data.aws_availability_zones.available.names))
  )

  public_subnet_cidrs = [
    for idx, _az in local.selected_azs :
    cidrsubnet(var.vpc_cidr, var.public_subnet_newbits, idx)
  ]

  private_subnet_cidrs = [
    for idx, _az in local.selected_azs :
    cidrsubnet(var.vpc_cidr, var.private_subnet_newbits, var.private_subnet_netnum_offset + idx)
  ]
}
