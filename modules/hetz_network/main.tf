resource "hcloud_network" "privnet" {
  name     = "my-net"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "privnet_subnet" {
  network_id   = hcloud_network.privnet.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_primary_ip" "ipv4" {
  name          = "primary_ipv4_server"
  datacenter    = "fsn1-dc14"
  type          = "ipv4"
  assignee_type = "server"
  auto_delete   = false
  #labels = {
  #  "hallo" : "welt"
  #}
}

resource "hcloud_primary_ip" "ipv6" {
  name          = "primary_ipv6_server"
  datacenter    = "fsn1-dc14"
  type          = "ipv6"
  assignee_type = "server"
  auto_delete   = false
}

resource "hcloud_firewall" "firewall" {
  name = "server-firewall"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = var.ssh_ips
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}
