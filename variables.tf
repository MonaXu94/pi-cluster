variable "master_ips" {
  description = "IP addresses of the Raspberry Pi master nodes"
  type        = list(string)
}

variable "cluster_name" {
  description = "Name of the k3s cluster"
  type        = string
}
