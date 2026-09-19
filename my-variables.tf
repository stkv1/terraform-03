variable "vm_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "platform_id" {
  type    = string
  default = "standard-v3"
}

variable "count_vm_cores" {
  type    = number
  default = 2
}

variable "count_vm_memory" {
  type    = number
  default = 1
}

variable "count_vm_fraction" {
  type    = number
  default = 20
}

variable "count_vm_preemptible" {
  type    = bool
  default = true
}

variable "count_vm_nat" {
  type    = bool
  default = true
}

# Переменные для for_each_vm (master-replica)
variable "each_vm" {
  description = "Параметры, отличающиеся для инстансов"
  type = map(object({
    vm_name        = string
    vm_cores       = number
    vm_memory      = number
    vm_fraction    = number
    vm_volume      = number
    vm_preemptible = bool
    vm_nat         = bool
  }))

  default = {
    "main" = {
      vm_name        = "main"
      vm_cores       = 2
      vm_memory      = 1
      vm_fraction    = 20
      vm_volume      = 10
      vm_preemptible = true
      vm_nat         = true
    }
    "replica" = {
      vm_name        = "replica"
      vm_cores       = 4
      vm_memory      = 2
      vm_fraction    = 50
      vm_volume      = 15
      vm_preemptible = true
      vm_nat         = true
    }
  }
}

# Переменные для storage в задании 3
variable "zone" {
  type = string
  default = "ru-central1-a"
}

variable "disk_type" {
  type = string
  default = "network-hdd"
}

variable "disk_size" {
  type = number
  default = 1
}

variable "storage_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}