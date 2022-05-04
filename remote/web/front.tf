resource "yandex_compute_instance_group" "front_tg" {
  name = "front-vm-instance-group"
  //folder_id          = "b1gjf0jsh3mgtuapmjuv"
  service_account_id = yandex_iam_service_account.service_account.id
  //deletion_protection = false
  instance_template {
    name        = "front-{instance.index}"
    platform_id = "standard-v1"
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
      subnet_ids = [module.front_subnet_a.subnet_id, module.front_subnet_b.subnet_id, module.front_subnet_c.subnet_id]
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
    //zones = ["ru-central1-a"]
    zones = [var.cloud_zone[0], var.cloud_zone[1], var.cloud_zone[2]]
  }

  application_load_balancer {
    target_group_name = "front-tg"
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
    max_creating    = 2
  }

  depends_on = [
    yandex_resourcemanager_folder_iam_binding.service_account_role,
  ]
}

resource "yandex_alb_backend_group" "web_alb_bg" {
  name = "web-fornt-alb-backeng-group"

  http_backend {
    name   = "test-http-backend"
    weight = 1
    port   = 8080
    //target_group_ids = ["${yandex_alb_target_group.test-target-group.id}"]
    target_group_ids = [yandex_compute_instance_group.front_tg.application_load_balancer[0].target_group_id]
    //  tls {
    //    sni = "backend-domain.internal"
    //  }
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      http_healthcheck {
        path = "/"
      }
    }
    http2 = "true"
  }
}

resource "yandex_alb_http_router" "web_router" {
  name = "web-front-router"
}

resource "yandex_alb_virtual_host" "web_hs" {
  name           = "web-app"
  http_router_id = yandex_alb_http_router.web_router.id
  //authority      = "cdn.yandexcloud.example"

  route {
    name = "web-route-to-front"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.web_alb_bg.id
      }
    }
  }
}

resource "yandex_alb_load_balancer" "front_alb" {
  name = "web-front-alb"

  //network_id = yandex_vpc_network.test-network.id
  network_id = module.web_vpc.vpc_id

  allocation_policy {
    location {
      zone_id   = var.cloud_zone[0]
      subnet_id = module.front_subnet_a.subnet_id
    }
    location {
      zone_id   = var.cloud_zone[1]
      subnet_id = module.front_subnet_b.subnet_id
    }
    location {
      zone_id   = var.cloud_zone[2]
      subnet_id = module.front_subnet_c.subnet_id
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [8080]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.web_router.id
      }
    }
  }
}
