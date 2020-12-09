resource "proxmox_vm_qemu" "docker" {
  depends_on = [proxmox_vm_qemu.docker-master]
  count = 1
  name = "docker${count.index}"
  desc = "Portainer agent VM."
  target_node = var.pm.node

  clone = var.pm.template
  full_clone = "true"
  
  os_type = "cloud-init"

  boot = "c"
  bootdisk = "scsi0"
  agent = 1

  memory = 4096
  cores = 4

  disk {
    size = "32G"
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
