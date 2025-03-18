variable "region" {
  type = string
  description = "AWS Region"
  default = "us-east-1"
}

variable "private_ip" {
  description = "Private IP"
  type = string
  default = "10.20.1.10"
}