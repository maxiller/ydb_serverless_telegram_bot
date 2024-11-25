## All of the below should be passed as env vars

variable "LOG_LEVEL" {
  type    = string
  default = "DEBUG"
}
variable "TIMEOUT_SHORT" {
  type    = number
  default = 10
}
variable "TIMEOUT_LONG" {
  type    = number
  default = 45
}
variable "QUEUE_BATCH" {
  type    = number
  default = 7
}
variable "CONCURRENCY" {
  type    = number
  default = 1
}
variable "QUEUE_DELAY" {
  type    = number
  default = 15
}

# Yandex Cloud folder vars
variable "YC_FOLDER_NAME" {
  type = string
  # default = env("YC_FOLDER_NAME")
  # ENV var
}
variable "YC_FOLDER_DESCRIPTION" {
  type = string
  # default = env("YC_FOLDER_DESCRIPTION")
  # ENV var
}
variable "YC_CLOUD_ID" {
  type = string
  # default = env("YC_CLOUD_ID")
  # ENV var
}

# Telegram API vars
variable "TELEGRAM_API_ID" {
  type = string
  # default = env("TELEGRAM_API_ID")
  description = "Telegram client API ID"
}
# data "yandex_lockbox_secret" "telegram_api_id" {
#   secret_id = var.TELEGRAM_API_ID.id
# }

variable "TELEGRAM_API_HASH" {
  type        = string
  description = "Telegram client API HASH"
  # default = env("TELEGRAM_API_HASH")
}
# data "yandex_lockbox_secret" "telegram_api_hash" {
#   secret_id = var.TELEGRAM_API_HASH
# }

variable "TELEGRAM_CLIENT_SESSION" {
  type        = string
  description = "Telegram client stringified session"
  # default = env("TELEGRAM_CLIENT_SESSION")
}
# data "yandex_lockbox_secret" "telegram_client_session" {
#   secret_id = var.TELEGRAM_CLIENT_SESSION
# }

variable "TELEGRAM_BOT_API_KEY" {
  type        = string
  description = "Telegram BOT API"
  # default = env("TELEGRAM_BOT_API_KEY")
}
# data "yandex_lockbox_secret" "telegram_bot_api_key" {
#   secret_id = var.TELEGRAM_BOT_API_KEY
# }

## Database
variable "DATABASE_NAME" {
  type        = string
  description = "Backend database name"
  default     = "telegram-backend-db"
}
variable "EVENTS_TABLE" {
  type        = string
  description = "PUSH events table"
  default     = "push-events"
}
variable "POSTS_TABLE" {
  type        = string
  description = "Clean posts table"
  default     = "posts"
}
variable "TARGETS_TABLE" {
  type        = string
  description = "Clean posts table"
  default     = "targets"
}
