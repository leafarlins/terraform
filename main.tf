module "network_hetz" {
  source = "./modules/hetz_network"
  ssh_ips = var.ssh_ips
  providers = { hcloud = hcloud.hetz }
}

module "server_hetz" {
  source = "./modules/hetz_server"
  ipv4 = module.network_hetz.ipv4_id
  ipv6 = module.network_hetz.ipv6_id
  network_id = module.network_hetz.network_id
  firewall_id = module.network_hetz.firewall_id
  providers = { hcloud = hcloud.hetz }
}
