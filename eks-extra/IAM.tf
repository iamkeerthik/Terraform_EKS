# resource "aws_iam_policy" "ebs_csi_iam_policy" {
#   name        = "${local.name}-AmazonEKS_EBS_CSI_Driver_Policy"
#   path        = "/"
#   description = "EBS CSI IAM Policy"
#   policy = data.http.ebs_csi_iam_policy.response_body
# }

# output "ebs_csi_iam_policy_arn" {
#   value = aws_iam_policy.ebs_csi_iam_policy.arn 
# }

# Resource: Create IAM Role and associate the EBS IAM Policy to it
resource "aws_iam_role" "ebs_csi_iam_role" {
  name = "${var.name}-ebs-csi-role"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${data.terraform_remote_state.local_state.outputs.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {            
            "${data.terraform_remote_state.local_state.outputs.aws_iam_openid_connect_provider_url}:sub": "system:serviceaccount:kube-system:aws-csi-driver"

          }
        }        

      },
    ]
  })

  tags = {
    tag-key = "${var.name}-ebs-csi-iam-role"
  }
}

# Associate EBS CSI IAM Policy to EBS CSI IAM Role
resource "aws_iam_role_policy_attachment" "ebs_csi_iam_role_policy_attach" {
  policy_arn = data.aws_iam_policy.AmazonEBSCSIDriverPolicy.arn
  role       = aws_iam_role.ebs_csi_iam_role.name
}

# output "ebs_csi_iam_role_arn" {
#   description = "EBS CSI IAM Role ARN"
#   value = aws_iam_role.ebs_csi_iam_role.arn
# }

# Resource: Create IAM Role and associate the EBS IAM Policy to it
resource "aws_iam_role" "lbc_iam_role" {
  name = "${var.name}-lbc-role"

  # Terraform's "jsonencode" function converts a Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Federated = "${data.terraform_remote_state.local_state.outputs.aws_iam_openid_connect_provider_arn}"
        }
        Condition = {
          StringEquals = {            
            "${data.terraform_remote_state.local_state.outputs.aws_iam_openid_connect_provider_url}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller"
          }
        }        

      },
    ]
  })

  tags = {
    tag-key = "${var.name}-lbc-role"
  }
}

# Associate EBS CSI IAM Policy to EBS CSI IAM Role
resource "aws_iam_role_policy_attachment" "lbc_role_policy_attach" {
  policy_arn = data.aws_iam_policy.lbcPolicy.arn
  role       = aws_iam_role.lbc_iam_role.name
}

# output "ebs_csi_iam_role_arn" {
#   description = "LBC IAM Role ARN"
#   value = aws_iam_role.ebs_csi_iam_role.arn
# }