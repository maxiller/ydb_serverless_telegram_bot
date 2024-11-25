resource "yandex_iam_service_account" "sa_folder" {
  folder_id   = yandex_resourcemanager_folder.root_folder.id
  description = "General SA to run application in this folder"
  name        = "sa-general-${yandex_resourcemanager_folder.root_folder.name}"
}
# resource "yandex_iam_service_account" "sa_pull" {
#   folder_id   = yandex_resourcemanager_folder.root_folder.id
#   description = "PULL function Service Account"
#   name        = "sa-pull-${yandex_resourcemanager_folder.root_folder.name}"
# }
# resource "yandex_iam_service_account" "sa_push" {
#   folder_id   = yandex_resourcemanager_folder.root_folder.id
#   description = "PUSH function Service Account"
#   name        = "sa-push-${yandex_resourcemanager_folder.root_folder.name}"
# }
# resource "yandex_iam_service_account" "sa_gpt" {
#   folder_id   = yandex_resourcemanager_folder.root_folder.id
#   description = "GPT function Service Account"
#   name        = "sa-gpt-${yandex_resourcemanager_folder.root_folder.name}"
# }
resource "yandex_iam_service_account_static_access_key" "sa_static_key" {
  service_account_id = yandex_iam_service_account.sa_folder.id
  description        = "static_access_key for General SA"
}

resource "yandex_resourcemanager_folder_iam_binding" "function_invoker_role" {
  folder_id = yandex_resourcemanager_folder.root_folder.id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
  role = "functions.functionInvoker"
}
resource "yandex_resourcemanager_folder_iam_binding" "logging_writer_role" {
  folder_id = yandex_resourcemanager_folder.root_folder.id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
  role = "logging.writer"
}
resource "yandex_resourcemanager_folder_iam_binding" "access_key_admin" {
  folder_id = yandex_resourcemanager_folder.root_folder.id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
  role = "iam.serviceAccounts.accessKeyAdmin"
}
resource "yandex_resourcemanager_folder_iam_binding" "static_key_admin" {
  folder_id = yandex_resourcemanager_folder.root_folder.id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
  role = "iam.serviceAccounts.authorizedKeyAdmin"
}
resource "yandex_resourcemanager_folder_iam_binding" "ymq_reader_role" {
  folder_id = yandex_resourcemanager_folder.root_folder.id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
  role = "ymq.reader"
}
resource "yandex_resourcemanager_folder_iam_binding" "ymq_admin_role" {
  folder_id = yandex_resourcemanager_folder.root_folder.id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
  role = "ymq.admin"
}
resource "yandex_resourcemanager_folder_iam_binding" "ia_llm_role" {
  folder_id = yandex_resourcemanager_folder.root_folder.id
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
  role = "ai.languageModels.user"
}

output "access_key" {
  value     = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  sensitive = true
}

output "secret_key" {
  value     = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
  sensitive = true
}
