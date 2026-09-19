resource "yandex_compute_instance" "master-replica" {

  for_each    = var.each_vm
  name        = each.value.vm_name
  platform_id = var.platform_id

  resources {
    cores         = each.value.vm_cores
    memory        = each.value.vm_memory
    core_fraction = each.value.vm_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.vm_volume
    }
  }
  scheduling_policy {
    preemptible = each.value.vm_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = each.value.vm_nat
  }

  metadata = {
    ssh-keys = local.ssh_key
  }


  depends_on = [yandex_compute_instance.count_vm]


}