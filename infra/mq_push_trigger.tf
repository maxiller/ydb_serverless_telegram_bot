resource "yandex_function_trigger" "mq_push_trigger" {
  folder_id   = yandex_resourcemanager_folder.root_folder.id
  name        = "mq-push-trigger"
  description = "MQ trigger for PUSH fuction"
  message_queue {
    queue_id           = yandex_message_queue.api_push_mq.arn
    service_account_id = yandex_iam_service_account.sa_folder.id
    batch_cutoff       = 10
    batch_size         = 10
  }
  function {
    id                 = yandex_function.push_function.id
    service_account_id = yandex_iam_service_account.sa_folder.id
  }
}
