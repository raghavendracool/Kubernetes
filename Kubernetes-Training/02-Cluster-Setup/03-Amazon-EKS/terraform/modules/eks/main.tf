module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.26"

  cluster_name    = var.cluster_name
  cluster_version = var.kubernetes_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  # Make IAM role creation explicit for training visibility.
  create_iam_role         = true
  iam_role_name           = "${var.cluster_name}-cluster-role"
  iam_role_use_name_prefix = false

  enable_irsa = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    create_iam_role         = true
    iam_role_name           = "${var.cluster_name}-node-role"
    iam_role_use_name_prefix = false
    iam_role_additional_policies = {
      AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    }
  }

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    eks-pod-identity-agent = {
      most_recent = true
    }
  }

  eks_managed_node_groups = {
    app_ng = {
      instance_types = var.node_instance_types
      desired_size   = var.node_desired_size
      min_size       = var.node_min_size
      max_size       = var.node_max_size
      subnet_ids     = var.private_subnet_ids
      capacity_type  = "ON_DEMAND"

      labels = {
        role = "app"
      }

      tags = {
        Name = "${var.cluster_name}-app-ng"
      }
    }
  }

  tags = var.tags
}
