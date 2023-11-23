# Variables for Ansible provisioning with proper descriptions.

variable "private_key_path" {
  type        = string
  description = "The path to the private key file used for SSH access"
}

variable "path_to_script" {
  type        = string
  description = "The file path to the Ansible playbook"
}

variable "public_ip" {
  type        = string
  description = "The public IP address of the target machine for Ansible"
}

variable "ansible_extra_vars" {
  description = "Extra variables to pass to the Ansible playbook"
  type        = map(string)
  default     = {}
}

locals {
  # Concatenates each key-value pair in the ansible_extra_vars map into a command string.
  extra_vars_string = join(" ", [for k, v in var.ansible_extra_vars : format("%s='%s'", k, tostring(v))])
  # Ensures the extra_vars are correctly formatted for the ansible command.

  # Creates the --extra-vars argument for the ansible-playbook command if extra vars are present.
  ansible_extra_vars_command = length(var.ansible_extra_vars) > 0 ? format("--extra-vars '%s'", local.extra_vars_string) : ""
  # Ensures that the --extra-vars option is only added if there are extra variables provided.
}
