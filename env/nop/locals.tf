# Define local variables for reuse within this Terraform module.
locals {
  # Region for the Instances and configuration that will be created
  aws_region = "us-east-1"

  sg1_name        = "sg1"
  sg1_description = "Test Security Group"
  sg1_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  sg1_egress_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  # VM (Virtual Machine) configuration to specify the compute resources.
  vm1_name      = "vm-1"                  # Name identifier for the virtual machine.
  vm1_type      = "t2.nano"               # Machine type specifying a particular CPU/RAM configuration.
  vm1_image     = "ami-0fc5d935ebf8bc3bc" # OS image for the VM.
  vm1_disk_size = 8                       # Size of the VM's primary disk in GB.
  vm1_disk_type = "standard"              # Type of the VM's primary disk. (standard / gp2 / gp3 / io1 / io2 / sc1 / st1)

  disk1_name        = "disk1"    # Neme identifier of the disk.
  disk1_size        = 8          # Size of the disk in GB.
  disk1_type        = "standard" # Type of disk. (standard / gp2 / gp3 / io1 / io2 / sc1 / st1)
  disk1_device_name = "/dev/sdh" # The device name of the disk.

  # VM (Virtual Machine) configuration to specify the compute resources.
  vm2_name      = "vm-2"                  # Name identifier for the virtual machine.
  vm2_type      = "t2.nano"               # Machine type specifying a particular CPU/RAM configuration.
  vm2_image     = "ami-0fc5d935ebf8bc3bc" # OS image for the VM.
  vm2_disk_size = 8                       # Size of the VM's primary disk in GB.
  vm2_disk_type = "standard"              # Type of the VM's primary disk. (standard / gp2 / gp3 / io1 / io2 / sc1 / st1)

  # VPC (Virtual Private Cloud) configuration.
  vpc1_name = "main-vpc"      # Name identifier of the VPC.
  vpc1_cidr = "172.20.0.0/16" # Subnet of the whole VPC.

  # Subnet configuration.
  sub1_name = "main-public-sub" # Name identifier of the subnet.
  sub1_cidr = "172.20.0.0/24"   # Cidr of the subnet.

  # Subnet configuration.
  sub2_name = "main-privat-sub" # Name identifier of the subnet.
  sub2_cidr = "172.20.1.0/24"   # Cidr of the subnet.

  # NAT-Instance configuration.
  nat1_name = "main-nat-instance" # Name of the Nat-Instance

  # Key pair configuration.
  key1_name = "Laptop" # Name of the key pair
  key1_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhtELWTC/hIFrkkyEAtQbozzMv2YT0D08A+Bsbph9Fi5LEg8flZR50kBmqLRHQp0oU30Vm6oNuJkcxahieH5T1NnmgivBpk9R6gBFwPoUoZ9aqbMF4OzJmN27Zci6OhU/f0qlvZ0u+uEBk5jNuVvwbkXNq+SaZazq8Neo6tvepfgxwYg8VKblOqFWHdsuGMzhFGe6fPqAnAxCyOXZPP1TWQ2ggk6w2h9MM4KBF/gezZz5YmriIHiI+v0erZSIcC9HoD+sfzJ0ke0A5CQT9Ab/HwAfGyIA+PdxFZ3n7kEI9/WWtm/cLMl3iQ9UH3yKqFxYE2WVyaVRvkj157bdcO+Vi9qZ+KiOCJffq9aaBmNAs1v0uQxHe5syj8THtX/dQgeEewvD9wPnDMmOjZCpGtkFKf4iXuvZkMPQoQPe9fwBKzb4KaWf+ImqK0UuwAuwOcOB4rsJ1PHA6EnuYQWsn7sO1HljRtG+ODrmejytLr/AKRVxLyxSMywAeMWACPh+89JE= main\\manuel.regli@FENNB04206"
}