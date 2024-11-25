resource "null_resource" "clean_up_tmp" {
  provisioner "local-exec" {
    command = <<EOT
rm -rf ${path.module}/dist/
EOT
  }
  depends_on = [ 
    yandex_function.push_function
  ]
  triggers = {
    always_run = "${timestamp()}"
  }
}