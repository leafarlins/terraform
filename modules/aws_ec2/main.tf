resource "aws_key_pair" "site_auth" {
  key_name = "site_key"
  public_key = file("~/.ssh/leafarlins.pub")
}

resource "aws_instance" "node_2025" {
  instance_type = "t3a.micro"
  ami = var.ami_ec2
  key_name = aws_key_pair.site_auth.id
  vpc_security_group_ids = [var.sg]
  subnet_id = var.subnet
  user_data = file("${path.module}/userdata.tpl")
  ipv6_address_count = 1
  private_ip = var.private_ip

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "leafarlins-node"
  }

  #depends_on = [ aws_internet_gateway.site_internet_gateway ]

  # provisioner "local-exec" {
  #   command = templatefile("${path.module}/linux-ssh-config.tpl",{
  #       hostname = self.public_ip,
  #       user = "ec2-user",
  #       identityfile = "~/.ssh/leafarlins"
  #   })
  #   interpreter = ["bash","-c"]
  # }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.node_2025.id
  allocation_id = var.eip
}