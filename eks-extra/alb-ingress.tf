
resource "kubernetes_service_account" "alb-service-account" {
  metadata {
    name = "aws-load-balancer-controller"
    namespace = "kube-system"
    labels = {
        "app.kubernetes.io/name"= "aws-load-balancer-controller"
        "app.kubernetes.io/component"= "controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.lbc_iam_role.arn
      "eks.amazonaws.com/sts-regional-endpoints" = "true"
      "eks.amazonaws.com/token-support.kubernetes.io" = "true"
    }
  }
}

resource "helm_release" "controller" {
  name       = "eks"
  namespace = "kube-system"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  # values = [
  #   file("${path.module}/values.yaml")
  # ]
  
  set {
    name  = "clusterName"
    value = "dedicated-rnd-cluster"
  }
  set {
  name  = "serviceAccount.create"
  value = "false"
 }

set {
  name  = "serviceAccount.name"
  value = "aws-load-balancer-controller"
}
  
  set {
    name  = "replicaCount"
    value = "1"
  }

  # set {
  #   name  = "controller.serviceAccount.annotations.eks.amazonaws.com/role-arn"
  #   value = "${aws_iam_role.lbc_iam_role.arn}"
  # }

 depends_on = [
   kubernetes_service_account.alb-service-account
 ]
}