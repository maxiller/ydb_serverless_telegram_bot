terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}
provider "yandex" {
  cloud_id = var.YC_CLOUD_ID
  # token = yandex_iam_service_account_static_access_key.tf_sa_static_key.secret_key
  #   cloud_id is set as YC_CLOUD_ID
}

resource "yandex_resourcemanager_folder" "root_folder" {
  name        = var.YC_FOLDER_NAME
  description = var.YC_FOLDER_DESCRIPTION
}
