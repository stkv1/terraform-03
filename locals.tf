locals {
  ssh_pub = trimspace(file("~/.ssh/ssh-key-ya-cloud-2026.pub"))
  ssh_key = "ubuntu:${local.ssh_pub}"
}

locals {
  inventory = templatefile("${path.module}/inventory.tpl", {
    web_vms = [
      for vm in yandex_compute_instance.count_vm : {
        name   = vm.name
        fqdn   = vm.fqdn
        nat_ip = vm.network_interface[0].nat_ip_address
      }
    ]
    app_vms = {
      for k, vm in yandex_compute_instance.master-replica : k => {
        name   = vm.name
        fqdn   = vm.fqdn
        nat_ip = vm.network_interface[0].nat_ip_address
      }
    }
    storage_vm = {
      name   = yandex_compute_instance.storage.name
      fqdn   = yandex_compute_instance.storage.fqdn
      nat_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
    }
  })
}

resource "local_file" "inventory" {
  content  = local.inventory
  filename = "${path.module}/inventory.txt"
}

