locals {
  default_user = {
    #"ubuntu-2004-lts" = "ubuntu"
    "rocky-9-oslogin" = "rocky"
  }

  hosts = [
    for fam, inst in yandex_compute_instance.vm :
    {
      name = inst.name
      ip   = inst.network_interface[0].nat_ip_address
      user = lookup(local.default_user, fam, "ubuntu")
      grp  = "webservers"
    }
  ]
}
