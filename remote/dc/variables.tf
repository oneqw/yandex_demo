// ----------------- переменные для сети

variable "vpc_name" {
  default = "dc"
}

variable "cloud_zone" {
  default = "ru-central1-b"
}

variable "subnet_cidr" {
  default = "192.168.2.0/24"
}

variable "subnet_name" {
  default = "1c network"
}

variable "vpc_id" {
  default = "dc network"
}

// ----------------- переменные для ВМ 1С

variable "vm_name" {
  default = "onec-app"
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

// ----------------- переменные для DB 1c

variable "sql_name" {
  default = "onec-sql"
}

variable "flavor" {
  default = "s2.micro"
}

variable "disk_type" {
  default = "network-ssd"
}

variable "disk_size" {
  default = "10"
}

variable "db_name" {
  default = "onec"
}

variable "user_db" {
  default = "dba"
}

variable "user_db_password" {
  default = "dba12345678"
}
