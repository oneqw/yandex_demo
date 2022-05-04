resource "yandex_iam_service_account" "service_account" {
  name        = "web-service-acc"
  description = "service account to manage stend"
}

resource "yandex_resourcemanager_folder_iam_binding" "service_account_role" {
  folder_id = var.cloud-folder-id
  //folder_id = "b1gnsnmi33t9gp0jjm5e"
  role = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.service_account.id}",
  ]
}
