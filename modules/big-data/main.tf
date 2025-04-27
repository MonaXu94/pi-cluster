resource "helm_release" "hdfs" {
  name       = "hdfs"
  namespace  = "big-data"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "hadoop"
  version    = "10.1.0"
  values = [
    <<EOF
    hdfs:
      namenode:
        replicas: 1
      datanode:
        replicas: 2
    EOF
  ]
}

resource "helm_release" "spark" {
  name       = "spark"
  namespace  = "big-data"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "spark"
  version    = "13.0.0"
  values = [
    <<EOF
    master:
      replicas: 1
    EOF
  ]
}

resource "helm_release" "kafka" {
  name       = "kafka"
  namespace  = "big-data"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"
  version    = "14.3.0"
  values = [
    <<EOF
    replicas: 3
    EOF
  ]
}

resource "helm_release" "hive" {
  name       = "hive"
  namespace  = "big-data"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "hive"
  version    = "5.4.0"
  values = [
    <<EOF
    hiveServer2:
      replicas: 1
    EOF
  ]
}
