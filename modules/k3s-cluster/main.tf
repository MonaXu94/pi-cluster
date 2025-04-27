module "k3s_cluster" {
  source = "./modules/k3s-cluster"

  master_ips = [
  "192.168.1.101", "192.168.1.102", "192.168.1.103", "192.168.1.104"
  ]

  cluster_name = "k3s_cluster"
}