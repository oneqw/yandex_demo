resource "yandex_lb_network_load_balancer" "back_lb" {
  name = "backend-load-balancer"
  type = "internal"

  listener {
    name = "backend-lb-listener"
    port = 22

    internal_address_spec {
      //subnet_id  = yandex_vpc_subnet.vpn-subnet.id
      subnet_id  = module.backend_subnet_a.subnet_id
      ip_version = "ipv4"

      //address = "10.10.1.5"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.backend_ig.load_balancer[0].target_group_id

    healthcheck {
      name = "tcp-check"
      tcp_options {
        port = 22
      }
    }
  }
}

resource "yandex_compute_instance_group" "backend_ig" {
  name = "backend-vm-instance-group"
  //folder_id          = "b1gjf0jsh3mgtuapmjuv"
  service_account_id = yandex_iam_service_account.service_account.id
  //deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    name        = "backend-{instance.index}"
    resources {
      memory        = 2
      cores         = 2
      core_fraction = 5
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd800n45ob5uggkrooi8"
      }
    }

    network_interface {
      network_id = module.web_vpc.vpc_id
      //subnet_ids = [yandex_vpc_subnet.vpn-subnet.id]
      subnet_ids = [module.backend_subnet_a.subnet_id, module.backend_subnet_b.subnet_id, module.backend_subnet_c.subnet_id]
    }

    metadata = {
      ssh-keys = "umka:weerrttyyu"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.cloud_zone[0], var.cloud_zone[1], var.cloud_zone[2]]
  }

  load_balancer {
    target_group_name = "backend-tg"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 2
    timeout             = 1
    unhealthy_threshold = 2
    tcp_options {
      port = "22"
    }
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
    max_creating    = 1
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_binding.service_account_role,
  ]
}
