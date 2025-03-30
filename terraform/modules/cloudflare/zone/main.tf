resource "null_resource" "zone" {
  provisioner "local-exec" {
    command = "echo ${var.name}"
  }
}

resource "null_resource" "zone_alt" {
  provisioner "local-exec" {
    command = "echo ${var.name}"
  }
}