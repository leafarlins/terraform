resource "aws_vpc" "site_vpc" {
  cidr_block           = "10.20.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  assign_generated_ipv6_cidr_block = true
  

  tags = {
    Name = "leafarlins"
  }

}

resource "aws_subnet" "site_public_subnet" {
  vpc_id                  = aws_vpc.site_vpc.id
  cidr_block              = "10.20.1.0/24"
  #map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  ipv6_cidr_block = cidrsubnet(aws_vpc.site_vpc.ipv6_cidr_block, 8, 1)
  assign_ipv6_address_on_creation = true

  tags = {
    Name = "leafarlins-public"
  }
}

resource "aws_eip" "site_eip" {
  domain = "vpc"
  instance = aws_instance.dev_node_2024.id
}

# resource "aws_eip" "site_eip2" {
#   domain = "vpc"
#   instance = aws_instance.dev_node_2024.id
# }

resource "aws_internet_gateway" "site_internet_gateway" {
  vpc_id = aws_vpc.site_vpc.id

  tags = {
    Name = "leafarlins-igw"
  }
}

resource "aws_route_table" "site_public_rt" {
    vpc_id = aws_vpc.site_vpc.id

    tags = {
        Name = "leafarlins_public_rt"
    }
}

resource "aws_route" "default_route" {
    route_table_id = aws_route_table.site_public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.site_internet_gateway.id
    #destination_ipv6_cidr_block = "::/0"
}

resource "aws_route_table_association" "site_public_assoc" {
    subnet_id = aws_subnet.site_public_subnet.id
    route_table_id = aws_route_table.site_public_rt.id
}

resource "aws_security_group" "site_sg" {
  name = "leafarlins_sg"
  description = "dev security group"
  vpc_id = aws_vpc.site_vpc.id
  ingress {
    from_port = 22
    to_port = 22
    protocol = "TCP"
    cidr_blocks = ["66.131.186.77/32"]
    #ipv6_cidr_blocks = ["fe80::4c63:6ca0:1e8:afe/128"]
  }
  ingress {
    from_port = 0
    to_port = 80
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port = 0
    to_port = 443
    protocol = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_key_pair" "site_auth" {
  key_name = "site_key"
  public_key = file("~/.ssh/leafarlins.pub")
}

# resource "aws_instance" "dev_node" {
#   instance_type = "t3a.nano"
#   #ami = data.aws_ami.server_ami.id
#   ami = var.ami_ec2
#   key_name = aws_key_pair.site_auth.id
#   vpc_security_group_ids = [aws_security_group.site_sg.id]
#   subnet_id = aws_subnet.site_public_subnet.id
#   user_data = file("userdata.tpl")
#   ipv6_address_count = 1

#   root_block_device {
#     volume_size = 10
#   }

#   tags = {
#     Name = "leafarlins-node"
#   }

#   depends_on = [ aws_internet_gateway.site_internet_gateway ]

#   provisioner "local-exec" {
#     command = templatefile("linux-ssh-config.tpl",{
#         hostname = self.public_ip,
#         user = "ec2-user",
#         identityfile = "~/.ssh/leafarlins"
#     })
#     interpreter = ["bash","-c"]

#   }
# }

resource "aws_instance" "dev_node_2024" {
  instance_type = "t3a.micro"
  #ami = data.aws_ami.server_ami.id
  ami = var.ami_ec2
  key_name = aws_key_pair.site_auth.id
  vpc_security_group_ids = [aws_security_group.site_sg.id]
  subnet_id = aws_subnet.site_public_subnet.id
  user_data = file("userdata.tpl")
  ipv6_address_count = 1

  root_block_device {
    volume_size = 10
  }

  tags = {
    Name = "leafarlins-node"
  }

  depends_on = [ aws_internet_gateway.site_internet_gateway ]

  provisioner "local-exec" {
    command = templatefile("linux-ssh-config.tpl",{
        hostname = self.public_ip,
        user = "ec2-user",
        identityfile = "~/.ssh/leafarlins"
    })
    interpreter = ["bash","-c"]

  }
}