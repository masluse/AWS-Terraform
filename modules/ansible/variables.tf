variable "private_key_path" {
  type        = string
  description = "Disk type"
}

variable "path_to_script" {
  type        = string
  description = "Disk type"
}

variable "public_ip" {
  type        = string
  description = "Disk type"
}

variable "ansible_extra_vars" {
  description = "A map of extra vars for Ansible"
  type        = map(string)
  default     = {}
}


# Erzeugt einen Befehlsstring für extra-vars basierend auf der ansible_extra_vars Map
locals {
  // Ensure that extra_vars_string is a string
  extra_vars_string = join(" ", [for k, v in var.ansible_extra_vars : format("%s='%s'", k, tostring(v))])

  // Use format to build ansible_extra_vars_command to avoid type issues
  ansible_extra_vars_command = length(var.ansible_extra_vars) > 0 ? format("--extra-vars '%s'", local.extra_vars_string) : ""
}

