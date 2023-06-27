resource "kubernetes_service_account" "csi-service-account" {
  metadata {
    name = "aws-csi-driver"
    namespace = "kube-system"
    labels = {
        "app.kubernetes.io/name"= "aws-csi-driver"
        "app.kubernetes.io/component"= "driver"
    }
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.ebs_csi_iam_role.arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
    }
  }
}

resource "helm_release" "ebs-csi-driver" {
  depends_on = [kubernetes_service_account.csi-service-account]
  name       = "aws-ebs-csi-driver"

  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  # version    = # leave blank to use the latest

  namespace = "kube-system"

  set {
    name  = "controller.serviceAccount.create"
    value = "false"
  }
  
  set {
    name  = "replicaCount"
    value = "1"
  }
  set {
    name  = "controller.serviceAccount.name"
    value = "aws-csi-driver"
  }

  # set {
  #   name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
  #   value = "${aws_iam_role.ebs_csi_iam_role.arn}"
  # }
  
}