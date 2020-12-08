terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = ">=2.6.5"
    }
  }
  required_version = ">= 0.13"
}

provider "proxmox" {
  pm_api_url      = "https://${var.auth_pm.host}/api2/json"
  pm_user         = var.auth_pm.user
  pm_password     = var.auth_pm.pass
  pm_tls_insecure = var.auth_pm.insecure
}