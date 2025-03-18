output "security_group" {
  value = aws_security_group.site_sg.id
}

output "subnet" {
  value = aws_subnet.site_public_subnet.id
}

output "elastic_ip" {
  value = aws_eip.site_eip.public_ip
}

output "elastic_ip_id" {
  value = aws_eip.site_eip.id
}