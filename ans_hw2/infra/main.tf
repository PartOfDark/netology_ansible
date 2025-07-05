resource "yandex_vpc_network" "hw1_network" {
  name = "hw1-network"

}

resource "yandex_vpc_subnet" "hw1_subnet" {
  name           = "hw1-subnet"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.hw1_network.id
  v4_cidr_blocks = var.default_cidr
}

data "yandex_compute_image" "ubuntu" {
  for_each = toset(var.vm_family_list)
  family   = each.value
}

resource "yandex_compute_instance" "vm" {
  for_each = toset(var.vm_family_list)
  name     = "vm-${each.value}"
  zone     = var.default_zone
  resources {
    cores         = var.vm_props.cores
    core_fraction = var.vm_props.core_fraction
    memory        = var.vm_props.memory
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu[each.value].id
      size     = var.vm_props.disk_size
      type     = var.vm_props.disk_type
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.hw1_subnet.id
    nat       = var.vm_props.nat
  }
  scheduling_policy {
    preemptible = var.vm_props.preemptible
  }
  metadata = {
    "serial-port-enable" = var.vm_props.serial_port_enabled

    "ssh-keys" = format(
      "%s:%s",
      local.default_user[each.value],
      var.ssh_public_key
    )
  }
}
