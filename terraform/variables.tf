terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.42.0"
    }
    namecheap = {
      source = "namecheap/namecheap"
      version = ">= 2.1.2"
    }
  }
}
