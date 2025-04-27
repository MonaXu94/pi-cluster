resource "helm_release" "prometheus" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "29.2.1"
  namespace  = "monitoring"
  create_namespace = true

  values = [
    <<EOF
    prometheus:
      prometheusSpec:
        replicas: 1
    EOF
  ]
}
