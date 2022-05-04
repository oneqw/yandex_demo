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
  //backend = "local"
  //config = {
  //    path = "stend/remote/dc/terraform.tfstate"
  //  }

  backend = "s3"

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
}

module "web_vpc" {
  //source   = "../../modules/network/vpc"
  source   = "git::git@github.com:oneqw/yandex_modules.git//network/vpc"
  vpc-name = var.vpc_name
}

module "front_subnet_a" {
  //source      = "../../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.web_vpc.vpc_id
  cloud-zone  = var.cloud_zone[0]
  subnet-cidr = var.front_subnet_cidr[0]
  subnet-name = var.front_subnet_name[0]
}

module "front_subnet_b" {
  //source      = "../../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.web_vpc.vpc_id
  cloud-zone  = var.cloud_zone[1]
  subnet-cidr = var.front_subnet_cidr[1]
  subnet-name = var.front_subnet_name[1]
}

module "front_subnet_c" {
  //source      = "../../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.web_vpc.vpc_id
  cloud-zone  = var.cloud_zone[2]
  subnet-cidr = var.front_subnet_cidr[2]
  subnet-name = var.front_subnet_name[2]
}

module "backend_subnet_a" {
  //source      = "../../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.web_vpc.vpc_id
  cloud-zone  = var.cloud_zone[0]
  subnet-cidr = var.backend_subnet_cidr[0]
  subnet-name = var.backend_subnet_name[0]
}

module "backend_subnet_b" {
  //source      = "../../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.web_vpc.vpc_id
  cloud-zone  = var.cloud_zone[1]
  subnet-cidr = var.backend_subnet_cidr[1]
  subnet-name = var.backend_subnet_name[1]
}

module "backend_subnet_c" {
  //source      = "../../modules/network/subnet"
  source      = "git::git@github.com:oneqw/yandex_modules.git//network/subnet"
  vpc_id      = module.web_vpc.vpc_id
  cloud-zone  = var.cloud_zone[2]
  subnet-cidr = var.backend_subnet_cidr[2]
  subnet-name = var.backend_subnet_name[2]
}
