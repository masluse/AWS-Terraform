# AWS-Terraform
## Overview
This Terraform project consists of the configuration and deployment of cloud infrastructure resources. It includes the creation of Key pairs, NAT Instances, Virtual Machines, vpc and subnets within a cloud project.
## Modules at a Glance
- Ansible: Initializes an Ansible playbook, facilitating automated and scalable configuration management across multiple systems.
- Disks: Handles the creation, configuration, and assignment of persistent disks to virtual machines, ensuring reliable storage solutions.
- NAT Instance: Deploys a Network Address Translation (NAT) instance within a specified subnet, allowing for controlled internet access and resource communication.
- RDS (Relational Database Service): Provisions and manages a relational database in Amazon RDS, offering scalable, managed database services.
- Security Group: Constructs a security group that establishes network access rules, which can be applied to instances for secure network traffic control.
- Subnet: Designs and implements a subnet within a Virtual Private Cloud (VPC), enabling network segmentation and optimized resource allocation.
- Virtual Machine: Deploys and manages virtual machines (VMs), providing flexible, scalable computing resources tailored to specific needs.
- VPC (Virtual Private Cloud): Creates a Virtual Private Cloud, offering an isolated cloud network for enhanced security and control over AWS resources.
## Requirements
- Terraform (version 1.6 or newer)
``` bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```
- Ansible (version 2.15.6 or newer)
Remove old Ansible version
``` bash
sudo apt remove ansible
sudo apt --purge autoremove
```
Update and upgrade Rep
``` bash
sudo apt update
sudo apt upgrade
```
Configure Personal Package Archives to the latest version
``` bash
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible
```
Installing Ansible
``` bash
sudo apt install ansible
```
Access credentials for the cloud environment (~/.aws/credentials)
## Files (Tree)
```
.
├── env
│   ├── drive-automatic-add
│   │   ├── ansible.cfg
│   │   ├── locals.tf
│   │   ├── main.tf
│   │   ├── moduls.tf
│   │   ├── terraform.tfstate
│   │   └── terraform.tfstate.backup
│   └── Jokes-DB
│       ├── ansible.cfg
│       ├── locals.tf
│       ├── main.tf
│       ├── moduls.tf
│       ├── terraform.tfstate
│       └── terraform.tfstate.backup
├── modules
│   ├── ansible
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── disks
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── key_pair
│   │   ├── main.tf
│   │   ├── output.tf
│   │   └── variables.tf
│   ├── nat-instance
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── rds
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── security-group
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── subnet
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   ├── virtual-machine
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── README.md
└── scripts
    └── ansible
        ├── disk_add.yaml
        └── jokes-db.yaml
```
## Usage
To use this project, you should first customize your local configurations to specify your project details, such as account_id, display_name, project_id, region, zone, etc.
1. Clone the project to your local directory:
```
git clone https://github.com/masluse/AWS-Terraform
cd ./AWS-Terraform/env/nop/
```
2. Initialize Terraform to download the necessary provider plugins:
```
terraform init
```
3. Create a plan to review the changes to be applied:
```
terraform plan
```
4. Apply the configuration to create the resources:
```
terraform apply
```
## Module Usage
### ansible/disk_add
``` t
# This module is used to run Ansible playbooks against a provisioned VM for configuration management.
module "ansible1" {
  source           = "../../modules/ansible"              # Location of the Ansible module
  path_to_script   = "../../scripts/ansible/disk_add.yaml" # Path to the Ansible playbook file
  public_ip        = module.vm1.info.public_ip            # The public IP address of the provisioned VM
  private_key_path = local.private_key_path               # The path to the SSH private key for Ansible to use
  ansible_extra_vars = {                                  # Extra variables to pass to Ansible
    mnt_name = local.disk1_name,                       
    pvs = local.disk1_device_name
  }
  depends_on = [module.vm1, module.disk1]  # Ensures Ansible runs after VM is provisioned
}
```
### ansible/jokes-db
``` t
# This module is used to run Ansible playbooks against a provisioned VM for configuration management.
module "ansible1" {
  source           = "../../modules/ansible"              # Location of the Ansible module
  path_to_script   = "../../scripts/ansible/jokes-db.yaml" # Path to the Ansible playbook file
  public_ip        = module.vm1.info.public_ip            # The public IP address of the provisioned VM
  private_key_path = local.private_key_path               # The path to the SSH private key for Ansible to use
  ansible_extra_vars = {                                  # Extra variables to pass to Ansible
    username = local.rds1_username,                       # Username for RDS instance
    password = local.rds1_password,                       # Password for RDS instance
    endpoint = module.rds1.info.address,                  # Endpoint address for RDS instance
    port     = module.rds1.info.port                      # Port number for RDS instance
  }
  depends_on = [module.vm1, module.rds1] # Ensures Ansible runs after VM and RDS are provisioned
}
```
### disk
``` t
module "disk1" {
  source            = "../../modules/disk"             # Relative path to the disks module.
  name              = local.disk1_name                  # The name of the disk (local variable).
  availability_zone = module.vm1.info.availability_zone # Availability zone from vm1 module.
  device_name       = local.disk1_device_name           # Device name for the disk (local variable).
  size              = local.disk1_size                  # Size of the disk (local variable).
  type              = local.disk1_type                  # Type of the disk (local variable).
  aws_instance_id   = module.vm1.info.id                # AWS instance ID from vm1 module.
  depends_on        = [module.vm1]                      # Dependency on vm1 module completion.
}
```
### key_pair
``` t
# Define a module for provisioning an SSH key pair.
module "key1" {
  source = "../../modules/key_pair" # Specifies the path to the module's source code.
  name   = local.key1_name          # Sets the key pair name from a local variable.
  key    = local.key1_key           # Sets the public key for the key pair from a local variable.
}
```
### rds
``` t
# Initializes a module for creating an RDS instance with specified parameters.
module "rds1" {
  source                 = "../../modules/rds"                        # The path to the RDS module's source code.
  storage                = local.rds1_storage                         # The allocated storage for the RDS instance.
  db_name                = local.rds1_db_name                         # The database name for the RDS instance.
  engine                 = local.rds1_engine                          # The database engine (e.g., MySQL, PostgreSQL).
  engine_version         = local.rds1_engine_version                  # The version of the database engine.
  instance_class         = local.rds1_instance_class                  # The class of RDS instance (determines compute and memory capacity).
  username               = local.rds1_username                        # The master username for the RDS instance.
  password               = local.rds1_password                        # The master password for the RDS instance.
  vpc_security_group_ids = module.sg2.info.id                         # The ID of the security group associated with the RDS instance.
  subnet_ids             = [module.sub2.info.id, module.sub3.info.id] # The IDs of the subnets for the RDS instance.
  depends_on             = [module.sub2, module.sub3]                 # Ensures the subnet group is created after the specified subnets.
}
```
### security_group
``` t
# Initializes a module for creating a security group within the specified VPC.
module "sg1" {
  source        = "../../modules/security_group" # The path to the security group module's source code.
  vpc_id        = module.vpc1.info.id            # The ID of the VPC where the security group will be created.
  name          = local.sg1_name                 # The name for the security group, sourced from a local variable.
  description   = local.sg1_description          # The description for the security group, sourced from a local variable.
  ingress_rules = local.sg1_ingress_rules        # The ingress rules for the security group, sourced from a local variable.
  egress_rules  = local.sg1_egress_rules         # The egress rules for the security group, sourced from a local variable.
}
```
### subnet
``` t
# Establishes subnets within the VPC, can be pulic or private.
module "sub3" {
  source            = "../../modules/subnet"       # The path to the subnet module's source code.
  name              = local.sub3_name              # The desired name for the subnet, sourced from a local variable.
  cidr              = local.sub3_cidr              # The CIDR block to be used for the subnet, sourced from a local variable.
  vpc_id            = module.vpc1.info.id          # The ID of the VPC (created by the 'vpc1' module) where the subnet will reside.
  private           = true                         # Explicitly specifies that the subnet is private.
  availability_zone = local.sub3_availability_zone # The availability zone to host the subnet, sourced from a local variable.
  depends_on = [
    module.vpc1 # Ensures this subnet is created after the VPC is available.
  ]
}
```
### virtual_machine
``` t
# This module invocation creates a virtual machine instance with specified configurations.
module "vm1" {
  source          = "../../modules/virtual_machine" # Module source path
  name            = local.vm1_name                  # VM instance name
  image           = local.vm1_image                 # VM image ID or name
  type            = local.vm1_type                  # VM instance type (e.g., t2.micro)
  disk_size       = local.vm1_disk_size             # Root disk size in GB
  disk_type       = local.vm1_disk_type             # Root disk type (e.g., gp2, io1)
  subnet_id       = module.sub1.info.id             # Subnet ID where the VM is to be placed
  key_pair        = local.key1_name                 # Key pair for SSH access
  security_groups = module.sg1.info.id              # Security group IDs for the VM
  ssh_user        = local.vm1_ssh_user              # Default SSH user
  depends_on      = [module.sub1, module.key1]      # Ensures VM is created after the subnet and key pair
}
```
### vpc
``` t
# Module call to create a VPC using a predefined module.
module "vpc1" {
  source = "../../modules/vpc" # The relative file path to the source code of the 'vpc' module.
  name   = local.vpc1_name     # The name to assign to the VPC, sourced from a local variable.
  cidr   = local.vpc1_cidr     # The CIDR block for the VPC, sourced from a local variable.
}
```