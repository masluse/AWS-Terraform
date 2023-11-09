# Define local variables for reuse within this Terraform module.
locals {
  # Region for the Instances and configuration that will be created
  aws_region = "us-east-1"

  # VPC (Virtual Private Cloud) configuration.
  vpc1_name = "main-vpc"      # Name identifier of the VPC.
  vpc1_cidr = "172.16.0.0/16" # Subnet of the whole VPC.

  # Subnet configuration.
  sub1_name = "public-sub-1"  # Name identifier of the subnet.
  sub1_cidr = "172.16.0.0/24" # Cidr of the subnet.
  sub1_availability_zone = "us-east-1a"

  # Subnet configuration.
  sub2_name = "private-sub-1" # Name identifier of the subnet.
  sub2_cidr = "172.16.1.0/24" # Cidr of the subnet.
  sub2_availability_zone = "us-east-1b"

  # Subnet configuration.
  sub3_name = "private-sub-2" # Name identifier of the subnet.
  sub3_cidr = "172.16.2.0/24" # Cidr of the subnet.
  sub3_availability_zone = "us-east-1c"

  sg1_name        = "Application Server"
  sg1_description = "Application Server"
  sg1_ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    {
      from_port   = 8080
      to_port     = 8080
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

  sg2_name        = "DB Server"
  sg2_description = "DB Server"
  sg2_ingress_rules = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]
  sg2_egress_rules = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  rds1_engine         = "mariadb"
  rds1_engine_version = "10.6.14"
  rds1_instance_class = "db.t2.micro"
  rds1_password       = "mypassword"
  rds1_storage        = 20
  rds1_username       = "admin"
  rds1_db_name        = "jokedb"

  vm1_disk_size = 8
  vm1_disk_type = "standard"
  vm1_image     = "ami-0fc5d935ebf8bc3bc"
  vm1_name      = "application-server"
  vm1_type      = "t2.large"
  private_key_path = "/root/.ssh/id_rsa"
  vm1_ssh_user = "ubuntu"

  # Key pair configuration.
  key1_name = "Laptop" # Name of the key pair
  key1_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhtELWTC/hIFrkkyEAtQbozzMv2YT0D08A+Bsbph9Fi5LEg8flZR50kBmqLRHQp0oU30Vm6oNuJkcxahieH5T1NnmgivBpk9R6gBFwPoUoZ9aqbMF4OzJmN27Zci6OhU/f0qlvZ0u+uEBk5jNuVvwbkXNq+SaZazq8Neo6tvepfgxwYg8VKblOqFWHdsuGMzhFGe6fPqAnAxCyOXZPP1TWQ2ggk6w2h9MM4KBF/gezZz5YmriIHiI+v0erZSIcC9HoD+sfzJ0ke0A5CQT9Ab/HwAfGyIA+PdxFZ3n7kEI9/WWtm/cLMl3iQ9UH3yKqFxYE2WVyaVRvkj157bdcO+Vi9qZ+KiOCJffq9aaBmNAs1v0uQxHe5syj8THtX/dQgeEewvD9wPnDMmOjZCpGtkFKf4iXuvZkMPQoQPe9fwBKzb4KaWf+ImqK0UuwAuwOcOB4rsJ1PHA6EnuYQWsn7sO1HljRtG+ODrmejytLr/AKRVxLyxSMywAeMWACPh+89JE= main\\manuel.regli@FENNB04206"

}