// ----------------- переменные для внешних адресов

variable "vpc_name" {
  default = "web"
}

variable "cloud_zone" {
  default = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

// ----------------- переменные для внешних адресов

variable "front_subnet_cidr" {
  default = ["10.10.10.0/24", "10.10.20.0/24", "10.10.30.0/24"]
}

variable "front_subnet_name" {
  default = ["front_subnet_a", "front_subnet_b", "front_subnet_c"]
}

variable "backend_subnet_cidr" {
  default = ["10.20.10.0/24", "10.20.20.0/24", "10.20.30.0/24"]
}

variable "backend_subnet_name" {
  default = ["backend_subnet_a", "backend_subnet_b", "backend_subnet_c"]
}
