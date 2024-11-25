resource "yandex_ydb_database_serverless" "telegram_backend" {
  name      = var.DATABASE_NAME
  folder_id = yandex_resourcemanager_folder.root_folder.id
  # deletion_protection = true
  # База для управления бекендом
  serverless_database {
    enable_throttling_rcu_limit = false
    provisioned_rcu_limit       = 10
    # storage_size_limit          = 50
    throttling_rcu_limit = 0
  }
}

resource "yandex_ydb_table" "ydb_table_user_personal_info" {
  depends_on = [yandex_ydb_database_serverless.telegram_backend]
  # Таблица для хранения групп юзер-его каналы
  path              = "ydb-table-user-personal-info"
  connection_string = yandex_ydb_database_serverless.telegram_backend.ydb_full_endpoint
  column {
    name     = "user_id"
    type     = "UInt64"
    not_null = true
  }
  column {
    name     = "last_name" # can be either push or pull
    type     = "Utf8"
  }
  column {
    name     = "first_name" # can be either push or pull
    type     = "Utf8"
  }
  column {
    name     = "age"
    type     = "UInt64"
    not_null = true
  }
  primary_key = [
    "user_id",
  ]
}
resource "yandex_ydb_table" "ydb_table_states" {
  depends_on = [yandex_ydb_database_serverless.telegram_backend]
  # Таблица для хранения групп юзер-его каналы
  path              = "ydb-table-states"
  connection_string = yandex_ydb_database_serverless.telegram_backend.ydb_full_endpoint
  column {
    name     = "user_id"
    type     = "UInt64"
    not_null = true
  }
  column {
    name     = "state" # can be either push or pull
    type     = "Utf8"
  }
  primary_key = [
    "user_id",
  ]
}



resource "yandex_ydb_database_iam_binding" "db_editor" {
  depends_on  = [yandex_ydb_database_serverless.telegram_backend]
  database_id = yandex_ydb_database_serverless.telegram_backend.id
  role        = "ydb.editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.sa_folder.id}"
  ]
}

output "ydb_endpoint" {
  value = yandex_ydb_database_serverless.telegram_backend.ydb_full_endpoint
}
output "ydb_databse" {
  value = yandex_ydb_database_serverless.telegram_backend.database_path
}
