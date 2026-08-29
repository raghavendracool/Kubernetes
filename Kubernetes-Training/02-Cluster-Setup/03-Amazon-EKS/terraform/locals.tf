locals {
  default_public_subnets = [
    for subnet in data.aws_subnet.all : subnet.id
    if subnet.map_public_ip_on_launch
  ]

  default_public_azs = sort(distinct([
    for subnet in data.aws_subnet.all : subnet.availability_zone
    if subnet.map_public_ip_on_launch
  ]))

  selected_azs = slice(
    local.default_public_azs,
    0,
    min(var.private_subnet_count, length(local.default_public_azs))
  )

  private_subnet_cidrs = [
    for idx, _az in local.selected_azs :
    cidrsubnet(
      data.aws_vpc.default.cidr_block,
      var.private_subnet_newbits,
      var.private_subnet_netnum_offset + idx
    )
  ]
}
