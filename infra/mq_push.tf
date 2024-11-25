resource "yandex_message_queue" "api_push_mq" {
  depends_on                 = [yandex_iam_service_account_static_access_key.sa_static_key]
  name                       = "api-push-mq"
  visibility_timeout_seconds = var.TIMEOUT_LONG + 1
  message_retention_seconds  = 259200
  delay_seconds = var.QUEUE_DELAY * 2
  # Use this syntax to specify redrive_policy in JSON format
  # and to refer existing queue
  # redrive_policy = jsonencode({
  #   deadLetterTargetArn = yandex_message_queue.dlq_api_push.arn
  #   maxReceiveCount     = 3
  # })
  access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
}
# resource "yandex_message_queue" "dlq_api_push" {
#   depends_on = [yandex_iam_service_account_static_access_key.sa_static_key]
#   name       = "DLQ-api-push-mq"
#   access_key = yandex_iam_service_account_static_access_key.sa_static_key.access_key
#   secret_key = yandex_iam_service_account_static_access_key.sa_static_key.secret_key
# }

output "api_mq_url" {
  value = yandex_message_queue.api_push_mq.id
}
