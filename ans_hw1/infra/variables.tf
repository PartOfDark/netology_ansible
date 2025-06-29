variable "vm_props" {
  type = object({
    name                = string
    family              = string
    platform_id         = string
    preemptible         = bool
    nat                 = bool
    serial_port_enabled = bool
    cores               = number
    core_fraction       = number
    memory              = number
    disk_size           = number
    disk_type           = string
    network_id          = string
    subnet_id           = string
  })
  default = {
    name                = "default-vm"
    family              = "ubuntu-2004-lts"
    platform_id         = "standard-v3"
    preemptible         = true
    nat                 = true
    serial_port_enabled = true
    cores               = 2
    core_fraction       = 20
    memory              = 4
    disk_size           = 20
    disk_type           = "network-hdd"
    network_id          = "default"
    subnet_id           = "default"
  }

}

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID"

}
variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID"
}
variable "default_zone" {
  type        = string
  description = "Default Yandex Cloud Zone"
  default     = "ru-central1-b"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}



variable "vm_family_list" {
  type = list(string)
  default = [
    "ubuntu-2004-lts",
    "centos-7",
  ]
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public keys for VM access"
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF4aFsZ3srLjMqOekJi3W+u2T3VjIIwOvx0b9/VBeBjx rick@rick-L16P"
}
