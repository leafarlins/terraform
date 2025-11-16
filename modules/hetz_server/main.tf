resource "hcloud_ssh_key" "main" {
  name       = "site_key"
  public_key = file("~/.ssh/hetzcloud.pub")
}

resource "hcloud_ssh_key" "storagebox" {
  name       = "storagebox"
  public_key = file("~/.ssh/storagebox.pub")
}

resource "hcloud_server" "server1" {
  name        = "server-1"
  image       = "alma-10"
  server_type = "cx23"
  datacenter  = "fsn1-dc14"
  ssh_keys = [hcloud_ssh_key.main.id]
  public_net {
    ipv4_enabled = true
    ipv4 = var.ipv4
    ipv6_enabled = true
    ipv6 = var.ipv6
  }
  network {
    network_id = var.network_id
    ip         = "10.0.1.11"
    alias_ips  = [
      "10.0.1.6",
      "10.0.1.7"
    ]
  }
  firewall_ids = [var.firewall_id]
}
