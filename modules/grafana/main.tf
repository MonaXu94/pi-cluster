resource "helm_release" "grafana" {
  name       = "grafana"
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = "6.16.0"
  namespace  = "monitoring"
  create_namespace = true

  values = [
    <<EOF
    adminPassword: "admin"
    EOF
  ]
}
