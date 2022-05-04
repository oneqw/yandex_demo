output "vpc_id" {
  value = module.vpc_network.vpc_id
}

output "subnet_id" {
  value = module.subnet_network.subnet_id
}

output "vm_id" {
  value = module.office_vm.vm_id
}

output "subnet_cidr" {
  value = module.subnet_network.subnet_cidr
}

output "zone" {
  value = module.subnet_network.zone
}
