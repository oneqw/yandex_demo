provider "yandex" {
  token     = var.cloud-token
  cloud_id  = var.cloud-id
  folder_id = var.cloud-folder-id
  //  folder_id = "b1gjf0jsh3mgtuapmjuv"
  //zone      = "ru-central1-a"
  //zone = var.cloud-zone[0]
}

terraform {
  required_providers {
    yandex = {
      source  = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex"
      version = "0.72.0"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {

  }
}
