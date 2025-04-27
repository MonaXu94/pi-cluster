module "prometheus" {
  source = "./modules/prometheus"
}

module "grafana" {
  source = "./modules/grafana"
}

module "efk" {
  source = "./modules/efk"
}

module "big_data" {
  source = "./modules/big-data"
}

module "postgresql" {
  source = "./modules/postgresql"
}
