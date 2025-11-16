variable "ipv4" {
  type = number
  description = "Public IPv4"
}

variable "ipv6" {
  type = number
  description = "Public IPv6"
}

variable "network_id" {
  type = string
  description = "Network id"
}

variable "firewall_id" {
  type = string
  description = "Firewall id"
}
