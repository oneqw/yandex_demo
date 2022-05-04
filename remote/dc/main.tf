
module "vpc_network" {
  //source   = "../../modules/network/vpc"
  source   = "git::git@github.com:oneqw/yandex_modules.git//network/vpc"
  vpc-name = var.vpc_name
}

module "subnet_network" {
  //source      = "../../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.vpc_network.vpc_id
  cloud-zone  = var.cloud_zone
  subnet-cidr = var.subnet_cidr
  subnet-name = var.subnet_name
}

module "onec_vm" {
  //source          = "../../modules/vm"
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

/*
resource "yandex_mdb_mysql_cluster" "onec-mysql" {
  name        = var.sql_name
  environment = "PRESTABLE"
  network_id  = module.vpc_network.vpc_id
  version     = "8.0"
  //security_group_ids  = [ yandex_vpc_security_group.mysql-sg.id ]
  deletion_protection = false

  resources {
    resource_preset_id = var.flavor
    disk_type_id       = var.disk_type
    disk_size          = var.disk_size
  }

  database {
    name = var.db_name
  }

  user {
    name     = var.user_db
    password = var.user_db_password
    permission {
      database_name = var.db_name
      roles         = ["ALL"]
    }
  }

  host {
    zone      = var.cloud_zone
    subnet_id = module.subnet_network.subnet_id
  }
}
*/
