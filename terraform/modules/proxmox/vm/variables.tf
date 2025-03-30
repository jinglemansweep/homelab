variable "name" {
  description = "VM Name"
  type        = string
}

variable "vmid" {
  description = "VM ID"
  type        = number
}

variable "cores" {
  description = "VM Cores"
  type        = number
  default     = 1
}

variable "memory" {
  description = "VM Memory"
  type        = number
  default     = 1024
}

variable "state" {
  description = "VM State"
  type        = string
  default     = "running"
}

variable "boot" {
  description = "VM Boot"
  type        = string
  default     = "order=virtio0;ide2"
}

variable "iso" {
  description = "VM ISO"
  type        = string
}

variable "disk_storage" {
  description = "VM Disk Storage Type"
  type        = string
  default     = "local-lvm"
}

variable "disk_boot_size" {
  description = "VM Disk Boot Size"
  type        = string
  default     = "10G"
}

variable "disk_data_size" {
  description = "VM Disk Data Size"
  type        = string
  default     = "10G"
}

variable "qemu_agent" {
  description = "VM QEMU Agent"
  type        = bool
  default     = false
}

variable "net_model" {
  description = "VM Network Model"
  type        = string
  default     = "virtio"
}

variable "net_bridge" {
  description = "VM Network Bridge"
  type        = string
  default     = "vmbr0"
}

variable "net_mac_address" {
  description = "VM Network MAC Address"
  type        = string
}

variable "target_node" {
  description = "Proxmox Target Node"
  type        = string
}
