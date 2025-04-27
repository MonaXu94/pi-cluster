provider "kubernetes"{
    host = "https://${var.master_ip}:6443"
    cluster_ca_certificate = file("/etc/rancher/k3s/k3s.ctr")
    token = file("/etc/rancher/k3s/k3s.token")
}

provider "helm" {
    kubernetes {
        host = "https://${var.master_ip}:6443"
        cluster_ca_certificate = file("/etc/rancher/k3s/k3s.ctr")
        token = file("/etc/rancher/k3s/k3s.token")
    }
}

module "k3s"{
    source = "./terraform/k3s-cluster.tf"
    pi_ips = var.pi_ips
}
