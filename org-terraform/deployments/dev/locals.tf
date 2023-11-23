##############################################
### Locals for AWS resources
##############################################

locals {
    ##########################################
    ### AWS region
    ##########################################
    region = "eu-central-2" # Zurich

    ##########################################
    ### AWS EC2 key pair 1
    ##########################################
    ec2_key_name_1 = "mreglab-key-terraform-prj-1"
    ec2_key_key_1   = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDhtELWTC/hIFrkkyEAtQbozzMv2YT0D08A+Bsbph9Fi5LEg8flZR50kBmqLRHQp0oU30Vm6oNuJkcxahieH5T1NnmgivBpk9R6gBFwPoUoZ9aqbMF4OzJmN27Zci6OhU/f0qlvZ0u+uEBk5jNuVvwbkXNq+SaZazq8Neo6tvepfgxwYg8VKblOqFWHdsuGMzhFGe6fPqAnAxCyOXZPP1TWQ2ggk6w2h9MM4KBF/gezZz5YmriIHiI+v0erZSIcC9HoD+sfzJ0ke0A5CQT9Ab/HwAfGyIA+PdxFZ3n7kEI9/WWtm/cLMl3iQ9UH3yKqFxYE2WVyaVRvkj157bdcO+Vi9qZ+KiOCJffq9aaBmNAs1v0uQxHe5syj8THtX/dQgeEewvD9wPnDMmOjZCpGtkFKf4iXuvZkMPQoQPe9fwBKzb4KaWf+ImqK0UuwAuwOcOB4rsJ1PHA6EnuYQWsn7sO1HljRtG+ODrmejytLr/AKRVxLyxSMywAeMWACPh+89JE= main\\manuel.regli@FENNB04206"

    ##########################################
    ### List of EC2 key pairs
    ##########################################
    ec2_key_names = ["${ local.ec2_key_name_1 }"] # Key pair name
    ec2_key_keys   = ["${ local.ec2_key_key_1 }"]  # Public key for key pair

    ##########################################
    ### AWS VPC 1
    ##########################################
    vpc_virtual-private-cloud_name_1 = "mreglab-vpc-terraform-prj-1"
    vpc_virtual-private-cloud_cidr_1 = "172.16.0.0/16"

    ##########################################
    ### List of VPCs
    ##########################################
    vpc_virtual-private-cloud_names = ["${ local.vpc_virtual-private-cloud_name_1 }"] # VPC name
    vpc_virtual-private-cloud_cidrs = ["${ local.vpc_virtual-private-cloud_cidr_1 }"] # VPC CIDR block

    ##########################################
    ### AWS Subnet 1
    ##########################################
    vpc_subnet_name_1 = "mreglab-subnet-terraform-prj-1" 
    vpc_subnet_cidr_1 = "172.16.1.0/24"
    vpc_subnet_availability-zones_1 = "eu-central-2a"

    ##########################################
    ### List of subnets
    ##########################################
    vpc_subnet_names = ["${ local.vpc_subnet_name_1 }"] # Subnet name
    vpc_subnet_cidrs = ["${ local.vpc_subnet_cidr_1 }"] # Subnet CIDR block
    vpc_subnet_availability-zones = ["${ local.vpc_subnet_availability-zones_1 }"] # Subnet availability zone

    ##########################################
    ### AWS Security Group 1
    ##########################################
    ec2_security-group_name_1 = "mreglab-sg-terraform-prj-1"
    ec2_security-group_description_1 = "mreglab-sg-terraform-prj-1"
    ec2_security-group_ingress_rules_1 = [
        {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = []
        },
    ]
    ec2_security-group_egress_rules_1 = [
        {
        from_port   = 0
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        security_groups = []
        },
    ]

    ##########################################
    ### List of security groups
    ##########################################
    ec2_security-group_names = ["${ local.ec2_security-group_name_1 }"] # Security group name
    ec2_security-group_descriptions = ["${ local.ec2_security-group_description_1 }"] # Security group description
    ec2_security-group_ingress_rules = ["${ local.ec2_security-group_ingress_rules_1 }"] # Security group ingress rules
    ec2_security-group_egress_rules = ["${ local.ec2_security-group_egress_rules_1 }"] # Security group egress rules

    ##########################################
    ### AWS Virtual Machine 1
    ##########################################
    ec2_virtual-machine_name_1 = "mreglab-vm-terraform-prj-1"
    ec2_virtual-machine_image_1 = "ami-0fc5d935ebf8bc3bc"
    ec2_virtual-machine_type_1 = "t2.micro"
    ec2_virtual-machine_disk_size_1 = 8
    ec2_virtual-machine_disk_type_1 = "standard"
    ec2_virtual-machine_ssh_user_1 = "ubuntu"

    ##########################################
    ### List of virtual machines
    ##########################################
    ec2_virtual-machine_names = ["${ local.ec2_virtual-machine_name_1 }"] # Virtual machine name
    ec2_virtual-machine_images = ["${ local.ec2_virtual-machine_image_1 }"] # Virtual machine image
    ec2_virtual-machine_types = ["${ local.ec2_virtual-machine_type_1 }"] # Virtual machine type
    ec2_virtual-machine_disk_sizes = ["${ local.ec2_virtual-machine_disk_size_1 }"] # Virtual machine disk size
    ec2_virtual-machine_disk_types = ["${ local.ec2_virtual-machine_disk_type_1 }"] # Virtual machine disk type
    ec2_virtual-machine_ssh_users = ["${ local.ec2_virtual-machine_ssh_user_1 }"] # Virtual machine SSH user
}