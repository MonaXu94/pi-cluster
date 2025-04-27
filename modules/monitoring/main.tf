resource "helm_release" "prometheus_grafana" {
  name = "kube-prometheus-stack"
  namespace = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"

}