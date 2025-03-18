output "public_ip" {
  value = module.server.public_ip
}

output "ipv6_ip" {
  value = module.server.ipv6_ip
}

output "elastic_ip" {
  value = module.network.elastic_ip
}