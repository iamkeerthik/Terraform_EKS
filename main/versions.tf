# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12"
    }
  }
}
provider "aws" {
  profile = "Stage"
  region  = "ap-south-1"
}

# Terraform HTTP Provider Block
provider "http" {
  # Configuration options
}

provider "helm" {
  kubernetes {
    config_path = "C:/Users/keerthik.shenoy/.kube/config"
  }
}
# provider "kubernetes" {
#   host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
#   cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_ca_cert)
#   exec {
#     api_version = "client.authentication.k8s.io/v1alpha1"
#     args        = ["eks", "get-token", "--cluster-name", data.terraform_remote_state.eks.outputs.cluster_name]
#     command     = "aws"
#   }
# }

provider "kubernetes" {
  config_path = "C:/Users/keerthik.shenoy/.kube/config"

}