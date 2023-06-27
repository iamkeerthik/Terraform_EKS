terraform {
  backend "local" {
    path = "backend/terraform.tfstate"
  }
}

module "eks" {
  source                  = "../eks-module"
  name                    = var.name
  asg_desired_size        = var.asg_desired_size
  asg_max_size            = var.asg_max_size
  asg_min_size            = var.asg_min_size
  loki_desired_size       = var.loki_desired_size
  loki_max_size           = var.loki_max_size
  loki_min_size           = var.loki_min_size
  key_name                = var.key_name
  endpoint_private_access = var.endpoint_private_access
  endpoint_public_access  = var.endpoint_public_access
  eks_version             = var.eks_version
  eks_instance_type       = var.eks_instance_type
  cluster_role_name       = var.cluster_role_name
  node_role_name          = var.node_role_name
  region                  = var.region
  image_id                = var.image_id
  subnet1                 = var.subnet1
  subnet2                 = var.subnet2
  vpc                     = var.vpc

}

module "eks-extra" {
  source     = "../eks-extra"
  depends_on = [module.eks]
  region     = var.region
  name       = var.name

}