resource "null_resource" "telegram_webhook" {
  provisioner "local-exec" {
    command = <<EOT
curl -F "url=https://${yandex_api_gateway.webhook_api.domain}/push_update" "https://api.telegram.org/bot${var.TELEGRAM_BOT_API_KEY}/setWebhook"
EOT
  }
  # triggers = {
  #   always_run = "${timestamp()}"
  # }
}
