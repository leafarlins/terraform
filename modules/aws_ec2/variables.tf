variable "ami_ec2" {
  type = string
  description = "image ami ec2"
}

variable "sg" {
  type = string
  description = "Security Group"
}

variable "subnet" {
  description = "Subnet ID"
  type = string
}

variable "private_ip" {
  description = "Private IP"
  type = string
  default = "10.20.1.10"
}

variable "eip" {
  description = "Elastic IP ID"
  type = string  
}