module "network" {
  source = "./modules/aws_network"
}

module "server" {
  source = "./modules/aws_ec2"
  ami_ec2 = var.ami_ec2
  sg = module.network.security_group
  subnet = module.network.subnet
  eip = module.network.elastic_ip_id
}