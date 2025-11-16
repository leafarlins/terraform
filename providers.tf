terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

provider "aws" {
  region                   = var.region
  #shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "leafarlins"
}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
  alias = "hetz"
}
