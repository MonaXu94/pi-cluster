resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "10.3.14"
  namespace  = "database"
  create_namespace = true

  values = [
    <<EOF
    postgresqlPassword: "password"
    EOF
  ]
}
