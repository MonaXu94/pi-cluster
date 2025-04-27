resource "helm_release" "prometheus_grafana" {
  name       = "kube-prometheus-stack"
  namespace  = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "40.0.0"
  values = [
    <<EOF
    grafana:
      enabled: true
      ingress:
        enabled: true
        hosts:
          - grafana.local
    prometheus:
      enabled: true
      ingress:
        enabled: true
        hosts:
          - prometheus.local
    EOF
  ]
}
