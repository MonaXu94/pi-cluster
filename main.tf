module "k3s_cluster" {
  source = "./modules/k3s-cluster"
}

module "monitoring" {
  source = "./modules/monitoring"
}

module "logging" {
  source = "./modules/logging"
}

module "big_data" {
  source = "./modules/big-data"
}

module "ingress" {
  source = "./modules/ingress"
}
