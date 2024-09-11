output "public_ip" {
  value = aws_instance.dev_node_2024.public_ip
}

output "ipv6_ip" {
  value = aws_instance.dev_node_2024.ipv6_addresses[0]
}