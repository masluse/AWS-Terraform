# Define local variables for reuse within this Terraform module.
locals {
  aws_region = "us-east-1"
  # VM (Virtual Machine) configuration to specify the compute resources.
  vm1_name      = "vm-1"                  # Name identifier for the virtual machine.
  vm1_type      = "t2.nano"               # Machine type specifying a particular CPU/RAM configuration.
  vm1_image     = "ami-0fc5d935ebf8bc3bc" # OS image for the VM.
  vm1_disk_size = 8                       # Size of the VM's primary disk in GB.
  vm1_disk_type = "standard"

  # VM (Virtual Machine) configuration to specify the compute resources.
  vm2_name      = "vm-2"                  # Name identifier for the virtual machine.
  vm2_type      = "t2.nano"               # Machine type specifying a particular CPU/RAM configuration.
  vm2_image     = "ami-0fc5d935ebf8bc3bc" # OS image for the VM.
  vm2_disk_size = 8                       # Size of the VM's primary disk in GB.
  vm2_disk_type = "standard"

  vpc1_name = "main-vpc"
  vpc1_cidr = "172.20.0.0/16"

  sub1_name = "main-priv-sub"
  sub1_cidr = "172.20.0.0/24"

  sub2_name = "main-priv-sub"
  sub2_cidr = "172.20.1.0/24"

  key1_name = "Laptop"
  key1_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhtELWTC/hIFrkkyEAtQbozzMv2YT0D08A+Bsbph9Fi5LEg8flZR50kBmqLRHQp0oU30Vm6oNuJkcxahieH5T1NnmgivBpk9R6gBFwPoUoZ9aqbMF4OzJmN27Zci6OhU/f0qlvZ0u+uEBk5jNuVvwbkXNq+SaZazq8Neo6tvepfgxwYg8VKblOqFWHdsuGMzhFGe6fPqAnAxCyOXZPP1TWQ2ggk6w2h9MM4KBF/gezZz5YmriIHiI+v0erZSIcC9HoD+sfzJ0ke0A5CQT9Ab/HwAfGyIA+PdxFZ3n7kEI9/WWtm/cLMl3iQ9UH3yKqFxYE2WVyaVRvkj157bdcO+Vi9qZ+KiOCJffq9aaBmNAs1v0uQxHe5syj8THtX/dQgeEewvD9wPnDMmOjZCpGtkFKf4iXuvZkMPQoQPe9fwBKzb4KaWf+ImqK0UuwAuwOcOB4rsJ1PHA6EnuYQWsn7sO1HljRtG+ODrmejytLr/AKRVxLyxSMywAeMWACPh+89JE= main\\manuel.regli@FENNB04206"
}