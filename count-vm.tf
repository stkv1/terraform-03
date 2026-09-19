data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_family
}

resource "yandex_compute_instance" "count_vm" {
  count       = 2
  name        = "web-${count.index + 1}"
  platform_id = var.platform_id
  resources {
    cores         = var.count_vm_cores
    memory        = var.count_vm_memory
    core_fraction = var.count_vm_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.count_vm_preemptible
  }
  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.count_vm_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  metadata = {
    ssh-keys = local.ssh_key
  }
}
    