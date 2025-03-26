module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.14" # Check for the latest version on the Terraform registry

  cluster_name             = "${local.demo_name}"
  cluster_version          = "1.29"
  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  cluster_endpoint_private_access          = true
  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_group_defaults = {
    disk_size = 20
  }

  eks_managed_node_groups = {
    general = {
      desired_size = 1
      min_size     = 1
      max_size     = 1

      instance_types = ["t3.medium"]
      capacity_type  = "ON_DEMAND"
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "${local.demo_name}"
  }
}

resource "aws_eks_addon" "eks_pod_identity_agent" {
  cluster_name = module.eks.cluster_name
  addon_name   = "eks-pod-identity-agent"
}
