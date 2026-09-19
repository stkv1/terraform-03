resource "yandex_compute_disk" "example" {
  count      = 3
  name       = "my-disk-${count.index + 1}"
  type       = var.disk_type
  zone       = var.zone
  size       = var.disk_size
}

resource "yandex_compute_instance" "storage" {
  name       = "storage"
  zone       = var.zone
  
  resources {
    cores         = var.storage_resources.cores
    memory        = var.storage_resources.memory
    core_fraction = var.storage_resources.core_fraction
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
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.example
    content {
      disk_id = secondary_disk.value.id
    }
  }
  depends_on = [yandex_compute_disk.example]
}