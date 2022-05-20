
/*
module "vpc_network" {
  source   = "../modules/network/vpc"
  vpc-name = var.vpc_name
}
*/

module "vpc_network" {
  source   = "git::git@github.com:oneqw/yandex_modules.git//network/vpc"
  vpc-name = var.vpc_name
}


module "subnet_network" {
  //source      = "../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.vpc_network.vpc_id
  cloud-zone  = var.cloud_zone
  subnet-cidr = var.subnet_cidr
  subnet-name = var.subnet_name
}

module "office_vm" {
  //source          = "../modules/vm"
  source          = "git::git@github.com:oneqw/yandex_modules.git//vm"
  vm-name         = var.vm_name
  platform-id     = var.platform_id
  cloud-zone      = var.cloud_zone
  cpu-cores       = var.cpu_cores
  ram             = var.ram
  boot-dsk-img-id = var.img_id
  subnet-id       = module.subnet_network.subnet_id
  //sg_id = var.
}
  
 resource "null_resource" "example" {}
