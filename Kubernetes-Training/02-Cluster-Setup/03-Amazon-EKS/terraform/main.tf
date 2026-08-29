module "network" {
  source = "./modules/network"

  cluster_name         = var.cluster_name
  vpc_cidr             = var.vpc_cidr
  subnet_azs           = local.selected_azs
  public_subnet_cidrs  = local.public_subnet_cidrs
  private_subnet_cidrs = local.private_subnet_cidrs
  tags                 = var.tags
}

module "eks" {
  source = "./modules/eks"

  cluster_name        = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size
  tags                = var.tags

  # Private node groups require NAT and route setup to be fully ready before bootstrap.
  depends_on = [module.network]
}
