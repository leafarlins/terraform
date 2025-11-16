variable "ami_ec2" {
  type = string
  description = "image ami ec2"
}

variable "region" {
  type = string
  description = "AWS Region"
}

variable "hcloud_token" {
  sensitive = true
  type = string
}

variable "ssh_ips" {
  type = list(string)
  description = "IPs for ssh"
  default = []
}
