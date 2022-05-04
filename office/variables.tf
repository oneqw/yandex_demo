// ----------------- переменные для provider
/*
variable "access_key" {
  type      = string
  sensitive = true
}

variable "secret_key" {
  type      = string
  sensitive = true
}
*/
// ----------------- переменные для сети

variable "vpc_name" {
  default = "office"
}

variable "cloud_zone" {
  default = "ru-central1-a"
}

variable "subnet_cidr" {
  default = "192.168.1.0/24"
}

variable "subnet_name" {
  default = "office network"
}

variable "vpc_id" {
  default = "office network"
}

// ------------------------ настройки для VM
variable "vm_name" {
  default = "office-vm"
}

variable "platform_id" {
  default = "standard-v1"
}

variable "cpu_cores" {
  default = "2"
}

variable "ram" {
  default = "2"
}

variable "img_id" {
  type        = string
  description = "Yandex Cloud vm image CentOS 7"
  default     = "fd800n45ob5uggkrooi8"
}
