resource "null_resource" "ansible_provisioner" {

  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.public_ip}, --private-key ${var.private_key_path} ${local.ansible_extra_vars_command} ${var.path_to_script}"
  }
}
