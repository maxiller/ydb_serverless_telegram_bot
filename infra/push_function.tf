resource "null_resource" "push_files" {
  provisioner "local-exec" {
    command = <<EOT
rm -rf $(find ../ -type d -name '__pycache__')
mkdir -p ${path.module}/dist/tmp
cp -aft ${path.module}/dist/tmp/ ${path.module}/../*.py ${path.module}/../*.md ${path.module}/../*.txt ${path.module}/../database ${path.module}/../user_interaction ${path.module}/../bot ${path.module}/../tests
EOT
  }
  triggers = {
    always_run = "${timestamp()}"
  }
}
data "archive_file" "push_function_src" {
  depends_on  = [null_resource.push_files]
  output_path = "${path.module}/dist/code.zip"
  type        = "zip"
  source_dir  = "${path.module}/dist/tmp/"
}

resource "yandex_function" "push_function" {
  description       = "Telegram PUSH function"
  folder_id         = yandex_resourcemanager_folder.root_folder.id
  name              = "push-function"
  runtime           = "python311"
  memory            = "128"
  concurrency       = 2
  execution_timeout = var.TIMEOUT_SHORT
  entrypoint        = "index.handler"
  log_options {
    log_group_id = yandex_logging_group.root_log.id
    min_level    = var.LOG_LEVEL
  }
  service_account_id = yandex_iam_service_account.sa_folder.id
  user_hash          = data.archive_file.push_function_src.output_base64sha256
  environment = {
    // set of env vars for the function
    TELEGRAM_BOT_API_KEY    = var.TELEGRAM_BOT_API_KEY
    TELEGRAM_API_ID         = var.TELEGRAM_API_ID
    TELEGRAM_API_HASH       = var.TELEGRAM_API_HASH
    TELEGRAM_CLIENT_SESSION = var.TELEGRAM_CLIENT_SESSION
    YDB_ENDPOINT            = yandex_ydb_database_serverless.telegram_backend.ydb_full_endpoint
    YDB_DATABASE            = yandex_ydb_database_serverless.telegram_backend.database_path
    # YDB_EVENTS_TABLE        = yandex_ydb_table.events.path
    LOG_LEVEL               = var.LOG_LEVEL
  }
  content {
    zip_filename = data.archive_file.push_function_src.output_path
  }
}
