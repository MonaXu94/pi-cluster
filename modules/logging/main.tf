resource "helm_release" "elasticsearch" {
  name       = "elasticsearch"
  namespace  = "logging"
  repository = "https://helm.elastic.co"
  chart      = "elasticsearch"
  version    = "7.10.0"
  values = [
    <<EOF
    esJavaOpts: "-Xms512m -Xmx512m"  # Limit Elasticsearch heap to 512MB (for Pi)
    clusterName: "es-cluster"
    EOF
  ]
}

resource "helm_release" "fluentbit" {
  name       = "fluent-bit"
  namespace  = "logging"
  repository = "https://fluent.github.io/helm-charts"
  chart      = "fluent-bit"
  version    = "2.0.0"
  values = [
    <<EOF
    service:
      type: ClusterIP
    inputs:
      - name: tail
        path: /var/log/*.log
    outputs:
      - name: es
        host: elasticsearch.logging.svc.cluster.local
        port: 9200
        logstash_format: true
    EOF
  ]
}

resource "helm_release" "kibana" {
  name       = "kibana"
  namespace  = "logging"
  repository = "https://helm.elastic.co"
  chart      = "kibana"
  version    = "7.10.0"
  values = [
    <<EOF
    ingress:
      enabled: true
      hosts:
        - kibana.local
    EOF
  ]
}
