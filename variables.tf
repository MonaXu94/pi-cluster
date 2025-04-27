variable "master_ip" {
  type = string
  default = "192.168.1.101" # the ip of your master node
}

variable "pi_ips" {
  type = list(string)
  default = ["192.168.1.101", "192.168.1.102", "192.168.1.103", "192.168.1.104"]
}

