data "terraform_remote_state" "office" {
  backend = "s3"

  config = {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "oblanit-terraform-test"
    key        = "stend/office/terraform.tfstate"
    region     = "ru-central1"
    access_key = "YCAJEe8t4zC0J4rpHCEnxDLcW"
    secret_key = "YCO5JcIjLARdZozV8UUeI787O4gvmBJNfyJsf-jk"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

data "terraform_remote_state" "dc" {
  backend = "s3"
  /*
  config = {
    bucket = "oblanit-terraform-test"
    key    = "stend/remote/dc/terraform.tfstate"
    region = "ru-central1"
  }
*/
  config = {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "oblanit-terraform-test"
    key        = "stend/remote/dc/terraform.tfstate"
    region     = "ru-central1"
    access_key = "YCAJEe8t4zC0J4rpHCEnxDLcW"
    secret_key = "YCO5JcIjLARdZozV8UUeI787O4gvmBJNfyJsf-jk"

    skip_region_validation      = true
    skip_credentials_validation = true
  }


  /*
  backend = "local"

  config = {
    path = "../dc2/terraform.tfstate"
  }
  */
}

resource "yandex_vpc_address" "local_ext_ip" {
  name = var.local_name_ext_ip

  external_ipv4_address {
    zone_id = data.terraform_remote_state.office.outputs.zone
  }
}

resource "yandex_vpc_address" "remote_ext_ip" {
  name = var.remote_name_ext_ip

  external_ipv4_address {
    zone_id = data.terraform_remote_state.dc.outputs.zone
  }
}


module "vpn_tunnel" {
  //source           = "../../modules/network/vpn/vpn_tunnel"
  source           = "git::git@github.com:oneqw/yandex_modules.git//network/vpn/vpn_tunnel"
  local_vpc_id     = data.terraform_remote_state.office.outputs.vpc_id
  local_route_name = var.vpn_local_route_name
  //local_dst_prefix = var.vpn_local_dst_prefix
  local_dst_prefix = data.terraform_remote_state.dc.outputs.subnet_cidr[0]

  remote_vpc_id     = data.terraform_remote_state.dc.outputs.vpc_id
  remote_route_name = var.vpn_remote_route_name
  //remote_dst_prefix = var.vpn_remote_dst_prefix
  remote_dst_prefix = data.terraform_remote_state.office.outputs.subnet_cidr[0]

  //local_name_ext_ip = var.local_name_ext_ip
  local_cloud_zone = data.terraform_remote_state.office.outputs.zone

  //remote_name_ext_ip = var.remote_name_ext_ip
  remote_cloud_zone = data.terraform_remote_state.dc.outputs.zone

  local_init_file_name    = var.vpn_local_init_file_name
  public_key_path         = var.vpn_public_key_path
  l_local_ext_ip_address  = yandex_vpc_address.local_ext_ip.external_ipv4_address[0].address
  l_remote_ext_ip_address = yandex_vpc_address.remote_ext_ip.external_ipv4_address[0].address
  ipsec_password          = var.vpn_ipsec_password
  local_name_vpn_vm       = var.vpn_local_name_vpn_vm
  local_hostname_vpn_vm   = var.vpn_local_hostname_vpn_vm
  local_subnet_id         = data.terraform_remote_state.office.outputs.subnet_id

  remote_init_file_name   = var.vpn_remote_init_file_name
  r_local_ext_ip_address  = yandex_vpc_address.remote_ext_ip.external_ipv4_address[0].address
  r_remote_ext_ip_address = yandex_vpc_address.local_ext_ip.external_ipv4_address[0].address
  remote_name_vpn_vm      = var.vpn_remote_name_vpn_vm
  remote_hostname_vpn_vm  = var.vpn_remote_hostname_vpn_vm
  remote_subnet_id        = data.terraform_remote_state.dc.outputs.subnet_id
}
