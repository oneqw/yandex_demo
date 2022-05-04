// ----------------- переменные для сети

variable "vpc_name" {
  default = "mng"
}

variable "cloud_zone" {
  default = "ru-central1-b"
}

variable "subnet_cidr" {
  default = "10.10.1.0/24"
}

variable "subnet_name" {
  default = "mng network"
}


/*
variable "vpc_id" {
  default = "office network"
}

variable "route_name" {
  default = "Route to DC"
}

variable "dst_prefix" {
  default = "192.168.2.0/24"
}

variable "nxt_hop" {
  default = "192.168.1.10"
}
*/


variable "vm_name" {
  default = "mng-vm"
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
