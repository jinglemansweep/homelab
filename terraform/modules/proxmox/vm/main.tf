terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc6"
    }
  }
}


resource "proxmox_vm_qemu" "vm" {

  vmid        = var.vmid
  name        = var.name
  cores       = var.cores
  memory      = var.memory
  vm_state    = var.state
  boot        = var.boot
  target_node = var.target_node
  agent       = var.qemu_agent ? 1 : 0

  network {
    id      = 0
    model   = var.net_model
    bridge  = var.net_bridge
    macaddr = var.net_mac_address
  }

  disks {
    ide {
      ide2 {
        cdrom {
          iso = var.iso
        }
      }
    }
    virtio {
      virtio0 {
        disk {
          size    = var.disk_boot_size
          storage = var.disk_storage
        }
      }
      virtio1 {
        disk {
          size    = var.disk_data_size
          storage = var.disk_storage
        }
      }
    }
  }

}
