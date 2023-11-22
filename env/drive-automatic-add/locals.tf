# Define local variables for reuse within this Terraform module.
locals {
  # AWS region configuration for created resources
  aws_region = "us-east-1"

  # VPC configuration
  vpc1_name = "drive-vpc"     # Name of the VPC
  vpc1_cidr = "172.16.0.0/16" # CIDR block for the VPC

  # Subnet configuration
  sub1_name              = "public-drive-sub-1" # Name of the subnet
  sub1_cidr              = "172.16.0.0/24"      # CIDR block for the subnet
  sub1_availability_zone = "us-east-1a"         # Availability zone for the subnet

  # Security group configuration
  sg1_name        = "Application Server" # Name for the security group
  sg1_description = "Application Server" # Description of the security group
  # Ingress rules for the security group
  sg1_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  # Egress rules for the security group
  sg1_egress_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  # Disk configuration
  disk1_name        = "disk1"     # Name of the disk
  disk1_size        = 8           # Size in GB
  disk1_type        = "standard"  # Type of the disk
  disk1_device_name = "/dev/sdg" # /dev/sdf-p Device name for the disk

  # VM configuration
  vm1_disk_size    = 8                       # Root disk size in GB for the VM
  vm1_disk_type    = "standard"              # Root disk type for the VM
  vm1_image        = "ami-0fc5d935ebf8bc3bc" # AMI ID for the VM
  vm1_name         = "application-server"    # Name of the VM
  vm1_type         = "t2.large"              # Instance type for the VM
  private_key_path = "/root/.ssh/id_rsa"     # Path to the private SSH key
  vm1_ssh_user     = "ubuntu"                # Default SSH user for the VM

  # Key pair configuration
  key1_name = "Laptop" # Name of the SSH key pair
  # SSH public key
  key1_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhtELWTC/hIFrkkyEAtQbozzMv2YT0D08A+Bsbph9Fi5LEg8flZR50kBmqLRHQp0oU30Vm6oNuJkcxahieH5T1NnmgivBpk9R6gBFwPoUoZ9aqbMF4OzJmN27Zci6OhU/f0qlvZ0u+uEBk5jNuVvwbkXNq+SaZazq8Neo6tvepfgxwYg8VKblOqFWHdsuGMzhFGe6fPqAnAxCyOXZPP1TWQ2ggk6w2h9MM4KBF/gezZz5YmriIHiI+v0erZSIcC9HoD+sfzJ0ke0A5CQT9Ab/HwAfGyIA+PdxFZ3n7kEI9/WWtm/cLMl3iQ9UH3yKqFxYE2WVyaVRvkj157bdcO+Vi9qZ+KiOCJffq9aaBmNAs1v0uQxHe5syj8THtX/dQgeEewvD9wPnDMmOjZCpGtkFKf4iXuvZkMPQoQPe9fwBKzb4KaWf+ImqK0UuwAuwOcOB4rsJ1PHA6EnuYQWsn7sO1HljRtG+ODrmejytLr/AKRVxLyxSMywAeMWACPh+89JE= main\\manuel.regli@FENNB04206"

}