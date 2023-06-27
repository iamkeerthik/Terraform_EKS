output "cluster_id" {
  value = aws_eks_cluster.suremdm-eks.cluster_id
}

output "eks_nodegroup_id" {
  value = aws_eks_node_group.worker-node-group.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.suremdm-eks.endpoint
}

output "cluster_ca_cert" {
  value = aws_eks_cluster.suremdm-eks.certificate_authority
}

output "cluster_name" {
  value = aws_eks_cluster.suremdm-eks.name
}

output "aws_iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.cluster.arn
}

output "aws_iam_openid_connect_provider_url" {
  value = aws_iam_openid_connect_provider.cluster.url
}