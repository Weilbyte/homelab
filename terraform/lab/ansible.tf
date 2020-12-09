resource "proxmox_vm_qemu" "ansible" {
  name = "ansible"
  desc = "Dedicated Ansible VM, used to provision other VMs.\nMust be setup manually."
  target_node = var.pm.node

  clone = var.pm.template
  full_clone = "true"
  
  os_type = "cloud-init"

  boot = "c"
  bootdisk = "scsi0"
  agent = 1

  memory = 3072
  cores = 2

  disk {
    size = var.pm.storage_base
    type = "scsi"
    ssd = "true"
    storage = var.pm.storage_ssd
  }

  network {
    model = "virtio"
    bridge = var.pm.net_server
  }

  lifecycle {
    ignore_changes = [
        nameserver,
        searchdomain,
        disk_gb,
        ssh_host,
        network,
        disk,
        ssh_port,
        ipconfig0,
        network,
    ]
  }
}
