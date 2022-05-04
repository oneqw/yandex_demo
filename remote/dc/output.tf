output "vpc_id" {
  value = module.vpc_network.vpc_id
}

output "subnet_id" {
  value = module.subnet_network.subnet_id
}

output "dc_vm_id" {
  value = module.onec_vm.vm_id
}

output "zone" {
  value = module.subnet_network.zone
}

output "subnet_cidr" {
  value = module.subnet_network.subnet_cidr
}
