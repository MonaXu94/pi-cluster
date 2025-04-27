resource "helm_release" "spark" {
  name       = "spark"
  repository = "https://bitnami-labs.github.io/charts"
  chart      = "spark"
  version    = "10.0.0"
  namespace  = "big-data"
  create_namespace = true
}

resource "helm_release" "kafka" {
  name       = "kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  version    = "14.0.0"
  namespace  = "big-data"
  create_namespace = true
}

resource "helm_release" "airflow" {
  name       = "airflow"
  repository = "https://airflow.apache.org"
  chart      = "airflow"
  version    = "2.2.0"
  namespace  = "big-data"
  create_namespace = true
}
