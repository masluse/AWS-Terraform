resource "time_sleep" "wait_40_seconds" {
  create_duration = "40s"
}

# A null resource that triggers local-exec provisioner to run Ansible playbook.
resource "null_resource" "ansible_provisioner" {
  # The local-exec provisioner invokes a local shell command.
  provisioner "local-exec" {
    command = "ansible-playbook -i ${var.public_ip}, --private-key ${var.private_key_path} ${local.ansible_extra_vars_command} ${var.path_to_script}"
    # The command to run the Ansible playbook with the provided inventory, private key, extra vars, and playbook path.
  }
  depends_on = [time_sleep.wait_40_seconds]

  # Trigger für die Neuausführung hinzufügen, basierend auf den Werten von ansible_extra_vars
  triggers = {
    ansible_vars_hash = md5(jsonencode({
      ansible_extra_vars = local.ansible_extra_vars_command,
      vm_name = var.public_ip
    })) 
  }
}