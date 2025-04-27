resource "kubernetes_ingress" "grafana_ingress" {
  metadata {
    name      = "grafana-ingress"
    namespace = "monitoring"
  }
  spec {
    rule {
      host = "grafana.local"
      http {
        path {
          path = "/"
          backend {
            service_name = "grafana"
            service_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress" "kibana_ingress" {
  metadata {
    name      = "kibana-ingress"
    namespace = "logging"
  }
  spec {
    rule {
      host = "kibana.local"
      http {
        path {
          path = "/"
          backend {
            service_name = "kibana"
            service_port = 5601
          }
        }
      }
    }
  }
}

resource "kubernetes_ingress" "prometheus_ingress" {
  metadata {
    name      = "prometheus-ingress"
    namespace = "monitoring"
  }
  spec {
    rule {
      host = "prometheus.local"
      http {
        path {
          path = "/"
          backend {
            service_name = "prometheus-kube-prometheus-prometheus"
            service_port = 9090
          }
        }
      }
    }
  }
}
