resource "null_resource" "zone" {
  provisioner "local-exec" {
    command = "echo ${var.name}"
  }
}