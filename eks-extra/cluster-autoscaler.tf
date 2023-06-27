resource "helm_release" "cluster_autoscaler" {
  name       = "cluster-autoscaler"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  namespace  = "kube-system"
#   version    = "2.0.0"

  set {
    name  = "autoDiscovery.enabled"
    value = "true"
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = "${data.terraform_remote_state.local_state.outputs.cluster_name}"
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "awsRegion"
    value = "${var.region}"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

#   set {
#     name  = "sslCertPath"
#     value = "/etc/ssl/certs/ca-bundle.crt"
#   }
}