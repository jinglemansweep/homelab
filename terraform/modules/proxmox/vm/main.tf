resource "proxmox_vm_qemu" "vm" {
  vmid        = var.vmid
  name        = var.name
  cores       = var.cores
  memory      = var.memory
  target_node = var.target_node
  disks {
    ide {
      ide2 {
        cdrom {
          iso = "ISO file"
        }
      }
    }
  }

}
