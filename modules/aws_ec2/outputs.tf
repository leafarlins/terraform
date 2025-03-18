output "public_ip" {
  value = aws_instance.node_2025.public_ip
}

output "ipv6_ip" {
  value = aws_instance.node_2025.ipv6_addresses[0]
}