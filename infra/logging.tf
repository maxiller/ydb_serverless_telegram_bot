resource "yandex_logging_group" "root_log" {
  name             = "root-log"
  folder_id        = yandex_resourcemanager_folder.root_folder.id
  retention_period = "72h"
}
output "loggin_group_id" {
  value = yandex_logging_group.root_log.id
}
