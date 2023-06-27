data "template_file" "user_data" {
  template = <<-EOF
    #!/bin/bash
    set -o xtrace
    /etc/eks/bootstrap.sh "${var.name}-cluster"
  EOF
}

#################################MAIN###################################
# Launch Template Resource
resource "aws_launch_template" "eks_launch_template" {
  name = "42G-AmzLinux2-EKS-${var.eks_version}-Hardened-withoutDomain-${var.name}"
  description = "42G-AmzLinux2-EKS-${var.eks_version}-Hardened-withoutDomain-${var.name}"
  image_id = var.image_id
#   instance_type = var.instance_type

#   vpc_security_group_ids = [module.private_sg.security_group_id]
  key_name = var.key_name
user_data = base64encode(data.template_file.user_data.rendered)
#   ebs_optimized = true
default_version = 1
#   update_default_version = true
#   block_device_mappings {
#     device_name = "/dev/sda1"
#     ebs {
#       volume_size = 10 
#       #volume_size = 20 # LT Update Testing - Version 2 of LT      
#       delete_on_termination = true
#       volume_type = "gp2" # default is gp2
#      }
#   }
#   monitoring {
#     enabled = true
#   }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.name}-eks"
    }
  }
}

# #######################################LOKI######################################

# # Launch Template Resource
# resource "aws_launch_template" "loki_launch_template" {
#   name = "42G-AmzLinux2-EKS-${var.eks_version}-Hardened-withoutDomain-${var.name}-Loki"
#   description = "42G-AmzLinux2-EKS-${var.eks_version}-Hardened-withoutDomain-${var.name}-Loki"
#   image_id = var.image_id
# #   instance_type = var.instance_type

# #   vpc_security_group_ids = [module.private_sg.security_group_id]
#   key_name = var.key_name
# #   user_data = filebase64("${path.module}/app1-install.sh")
# user_data = base64encode(data.template_file.user_data.rendered)
# #   ebs_optimized = true
# default_version = 1
# #   update_default_version = true
# #   block_device_mappings {
# #     device_name = "/dev/sda1"
# #     ebs {
# #       volume_size = 10 
# #       #volume_size = 20 # LT Update Testing - Version 2 of LT      
# #       delete_on_termination = true
# #       volume_type = "gp2" # default is gp2
# #      }
# #   }
# #   monitoring {
# #     enabled = true
# #   }

#   tag_specifications {
#     resource_type = "instance"
#     tags = {
#       Name = "${var.name}-eks-loki"
#     }
#   }
# }