output "ipv4" {
  value = hcloud_primary_ip.ipv4.ip_address
}

output "ipv6" {
  value = hcloud_primary_ip.ipv6.ip_address
}

output "ipv4_id" {
  value = hcloud_primary_ip.ipv4.id
}

output "ipv6_id" {
  value = hcloud_primary_ip.ipv6.id
}

output "network_id" {
  value = hcloud_network.privnet.id
}

output "firewall_id" {
  value = hcloud_firewall.firewall.id
}
