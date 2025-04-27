provider "kubernetes" {
  host                   = "https://${var.master_ips[0]}:6443"
  cluster_ca_certificate = file("${path.module}/certs/ca.crt")
  client_certificate     = file("${path.module}/certs/client.crt")
  client_key             = file("${path.module}/certs/client.key")
}

provider "helm" {
  kubernetes {
    host                   = "https://${var.master_ips[0]}:6443"
    cluster_ca_certificate = file("${path.module}/certs/ca.crt")
    client_certificate     = file("${path.module}/certs/client.crt")
    client_key             = file("${path.module}/certs/client.key")
  }
}

resource "null_resource" "install_k3s" {
  count = length(var.master_ips)

  provisioner "remote-exec" {
    inline = [
      "curl -sfL https://get.k3s.io | sh -"
    ]

    connection {
      host        = var.master_ips[count.index]
      user        = "pi"  # Update this based on your username
      private_key = file(var.ssh_private_key_path)
    }
  }

  depends_on = [
    null_resource.master_init
  ]
}

resource "null_resource" "master_init" {
  provisioner "remote-exec" {
    inline = [
      "sudo k3s server &"
    ]

    connection {
      host        = var.master_ips[0]
      user        = "pi"  # Update this based on your username
      private_key = file(var.ssh_private_key_path)
    }
  }

  depends_on = [
    null_resource.install_k3s
  ]
}

resource "kubernetes_cluster" "k3s_cluster" {
  name     = var.cluster_name
  location = var.location
}

output "kubeconfig" {
  value = kubernetes_cluster.k3s_cluster.kubeconfig_raw
}
