data "terraform_remote_state" "local_state" {
  backend = "local"

  config = {
    path = "../main/backend/terraform.tfstate"
  }
}



data "aws_iam_role" "lbc_role" {
  name = "AmazonEKSLoadBalancerControllerRole2"
}

data "aws_iam_role" "csi_role" {
  name = "AmazonEKS_EBS_CSI_DriverRole"

}
# data "tls_certificate" "eks" {
#   url = aws_eks_cluster.suremdm-eks.identity.0.oidc.0.issuer
# }

data "aws_iam_policy" "AmazonEBSCSIDriverPolicy" {
  name = "AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy" "lbcPolicy" {
  name = "AWSLoadBalancerControllerIAMPolicy"
}