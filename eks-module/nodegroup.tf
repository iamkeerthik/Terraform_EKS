
#####################################MAIN######################################
resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.suremdm-eks.name
  node_group_name = "${var.name}-Nodegroup"
  node_role_arn   = data.aws_iam_role.node_role.arn
  subnet_ids      = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
  instance_types  = [var.eks_instance_type]


  tags = {
    Name        = "${var.name}-Nodegroup"
    Environment = var.name
  }

  scaling_config {
    desired_size = var.asg_desired_size
    max_size     = var.asg_max_size
    min_size     = var.asg_min_size
  }

  launch_template {
    id      = aws_launch_template.eks_launch_template.id
    version = 1
  }

depends_on = [ aws_launch_template.eks_launch_template ]
}

# ####################################LOKI######################################

# resource "aws_eks_node_group" "loki-node-group" {
#   cluster_name    = aws_eks_cluster.suremdm-eks.name
#   node_group_name = "${var.name}-Loki-Nodegroup"
#   node_role_arn   = data.aws_iam_role.node_role.arn
#   subnet_ids      = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
#   instance_types  = [var.eks_instance_type]


#   tags = {
#     Name        = "${var.name}-Loki-Nodegroup"
#     Environment = "${var.name}-loki"
#   }

#   scaling_config {
#     desired_size = var.loki_desired_size
#     max_size     = var.loki_max_size
#     min_size     = var.loki_min_size
#   }

#   launch_template {
#     id      = aws_launch_template.loki_launch_template.id
#     version = 1
#   }

# depends_on = [ aws_launch_template.loki_launch_template ]
# }
