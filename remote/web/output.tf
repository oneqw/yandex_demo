/*
output "vpc_id" {
  value = module.vpc_network.vpc_id
}

output "subnet_id" {
  value = module.subnet_network.subnet_id
}

output "vm_id" {
  value = module.office_vm.vm_id
}
*/

output "sa_id" {
  value = yandex_iam_service_account.service_account.id
}
