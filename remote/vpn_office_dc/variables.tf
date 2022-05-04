// ----------------- переменные для внешних адресов

variable "local_name_ext_ip" {
  default = "office-ext-ip"
}

variable "remote_name_ext_ip" {
  default = "dc-exp-ip"
}

// ----------------- переменные для внешних адресов

variable "vpn_local_route_name" {
  default = "office route to vpn"
}

variable "vpn_local_dst_prefix" {
  default = "192.168.2.0/24"
}

variable "vpn_remote_route_name" {
  default = "dc route to vpn"
}

variable "vpn_remote_dst_prefix" {
  default = "192.168.1.0/24"
}

variable "vpn_local_init_file_name" {
  default = "local-init.tpl.yaml"
}

variable "vpn_public_key_path" {
  description = "Path to ssh public key, which would be used to access workers"
  default     = "~/.ssh/id_rsa.pub"
}

variable "vpn_ipsec_password" {
  default = "passw0rd"
}

variable "vpn_local_name_vpn_vm" {
  default = "vpn-to-dc"
}

variable "vpn_local_hostname_vpn_vm" {
  default = "vpn-to-dc"
}

variable "vpn_remote_init_file_name" {
  default = "remote-init.tpl.yaml"
}

variable "vpn_remote_name_vpn_vm" {
  default = "vpn-to-office"
}

variable "vpn_remote_hostname_vpn_vm" {
  default = "vpn-to-office"
}

variable "img_id" {
  type        = string
  description = "Yandex Cloud vm image CentOS 7"
  default     = "fd800n45ob5uggkrooi8"
}
