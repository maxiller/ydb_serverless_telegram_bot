resource "yandex_api_gateway" "webhook_api" {
  name = "webhook-api"
  description = "Public webhook interface"
  log_options {
    log_group_id = yandex_logging_group.root_log.id
    min_level = "INFO"
  }
  folder_id = yandex_resourcemanager_folder.root_folder.id
  spec = <<-EOT
openapi: 3.0.0
info:
  title: Push API
  version: 1.0.0
paths:
  /push_update:
    post:
      operationId: handleUpdate
      x-yc-apigateway-integration:
        type: cloud_functions
        function_id: ${yandex_function.push_function.id}
        folder_id: ${yandex_resourcemanager_folder.root_folder.id}
        service_account_id: ${yandex_iam_service_account.sa_folder.id}
EOT
}

output "apigw_url" {
  value = "https://${yandex_api_gateway.webhook_api.domain}/push_update"
}
