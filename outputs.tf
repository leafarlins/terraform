# aws outputs

#output "public_ip" {
#  value = module.server.public_ip
#}

#output "ipv6_ip" {
#  value = module.server.ipv6_ip
#}

#output "elastic_ip" {
#  value = module.network.elastic_ip
#}

# hetz cloud outputs

output "hetz_ipv4" {
  value = module.network_hetz.ipv4
}

output "hetz_ipv6" {
  value = module.network_hetz.ipv6
}
