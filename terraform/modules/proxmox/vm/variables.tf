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

variable "target_node" {
  description = "Proxmox Target Node"
  type        = string
}

variable "api_endpoint" {
  description = "Proxmox API Endpoint"
  type        = string
}

variable "api_username" {
  description = "Proxmox API Username"
  type        = string
}
variable "api_password" {
  description = "Proxmox API Password"
  type        = string
  sensitive   = true
}

variable "api_tls_insecure" {
  description = "Proxmox API TLS Insecure"
  type        = bool
  default     = true
}
