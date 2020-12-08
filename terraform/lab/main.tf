variable "pm" {}

terraform {
  backend "local" {}

  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">=2.6.5"
    }
  }
  required_version = ">= 0.13"
}
