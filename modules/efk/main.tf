resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.10.0"
  namespace  = "logging"
  create_namespace = true

  values = [
    <<EOF
    clusterName: "efk-cluster"
    nodeGroup: "master"
    EOF
  ]
}

resource "helm_release" "fluentbit" {
  name       = "fluentbit"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "2.10.0"
  namespace  = "logging"
  create_namespace = true
}

resource "helm_release" "kibana" {
  name       = "kibana"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = "7.10.0"
  namespace  = "logging"
  create_namespace = true

  values = [
    <<EOF
    kibana:
      host: "0.0.0.0"
    EOF
  ]
}
