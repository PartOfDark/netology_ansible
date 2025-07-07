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
  family = var.vm_family
}

resource "yandex_compute_instance" "vm" {
  count = 3
  name  = "vm-${var.vm_family}-${count.index + 1}"
  zone  = var.default_zone
  resources {
    cores         = var.vm_props.cores
    core_fraction = var.vm_props.core_fraction
    memory        = var.vm_props.memory
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
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
      local.default_user[var.vm_family],
      var.ssh_public_key
    )
  }
}
