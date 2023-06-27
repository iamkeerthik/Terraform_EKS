data "aws_availability_zones" "available_1" {
  state = "available"
}

data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc}"]
  }
}



data "aws_subnet" "subnet_1" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[0]
  filter {
    name   = "tag:Name"
    values = ["${var.subnet1}"]
  }
}

data "aws_subnet" "subnet_2" {
  vpc_id            = data.aws_vpc.vpc_available.id
  availability_zone = data.aws_availability_zones.available_1.names[1]
  filter {
    name   = "tag:Name"
    values = ["${var.subnet2}"]
  }
}

# data "aws_security_group" "eks-security" {
#   vpc_id = data.aws_vpc.vpc_available.id
#   filter {
#     name   = "tag:Name"
#     values = ["${var.name}-eks-sg"]
#   }

# }

data "aws_iam_role" "cluster_role" {
  name = var.cluster_role_name
}

data "aws_iam_role" "node_role" {
  name = var.node_role_name

}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.suremdm-eks.identity.0.oidc.0.issuer
}

