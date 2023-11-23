# Define a module for provisioning an SSH key pair.
module "key1" {
  source = "../../modules/key_pair" # Specifies the path to the module's source code.
  name   = local.key1_name          # Sets the key pair name from a local variable.
  key    = local.key1_key           # Sets the public key for the key pair from a local variable.
}

# Module call to create a VPC using a predefined module.
module "vpc1" {
  source = "../../modules/vpc" # The relative file path to the source code of the 'vpc' module.
  name   = local.vpc1_name     # The name to assign to the VPC, sourced from a local variable.
  cidr   = local.vpc1_cidr     # The CIDR block for the VPC, sourced from a local variable.
}

# Module call to create a subnet that is configured to be public within the VPC.
module "sub1" {
  source            = "../../modules/subnet"       # Path to the subnet module's source code.
  name              = local.sub1_name              # The desired name of the subnet from a local variable.
  cidr              = local.sub1_cidr              # The CIDR block for the subnet from a local variable.
  vpc_id            = module.vpc1.info.id          # The ID of the VPC in which to create the subnet, referenced from the 'vpc1' module.
  availability_zone = local.sub1_availability_zone # The availability zone to host the subnet, sourced from a local variable.
  depends_on = [
    module.vpc1 # Ensures this subnet is created after the VPC is available.
  ]
}

# Module call to create a subnet that is configured to be private within the VPC.
module "sub2" {
  source            = "../../modules/subnet"       # The path to the subnet module's source code.
  name              = local.sub2_name              # The desired name for the subnet, sourced from a local variable.
  cidr              = local.sub2_cidr              # The CIDR block to be used for the subnet, sourced from a local variable.
  vpc_id            = module.vpc1.info.id          # The ID of the VPC (created by the 'vpc1' module) where the subnet will reside.
  private           = true                         # Explicitly specifies that the subnet is private.
  availability_zone = local.sub2_availability_zone # The availability zone to host the subnet, sourced from a local variable.
  depends_on = [
    module.vpc1 # Ensures this subnet is created after the VPC is available.
  ]
}

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

# Initializes a module for creating a security group within the specified VPC.
module "sg1" {
  source        = "../../modules/security_group" # The path to the security group module's source code.
  vpc_id        = module.vpc1.info.id            # The ID of the VPC where the security group will be created.
  name          = local.sg1_name                 # The name for the security group, sourced from a local variable.
  description   = local.sg1_description          # The description for the security group, sourced from a local variable.
  ingress_rules = local.sg1_ingress_rules        # The ingress rules for the security group, sourced from a local variable.
  egress_rules  = local.sg1_egress_rules         # The egress rules for the security group, sourced from a local variable.
}


# Initializes a module for creating a security group within the specified VPC.
module "sg2" {
  source        = "../../modules/security_group" # The path to the security group module's source code.
  vpc_id        = module.vpc1.info.id            # The ID of the VPC where the security group will be created.
  name          = local.sg2_name                 # The name for the security group, sourced from a local variable.
  description   = local.sg2_description          # The description for the security group, sourced from a local variable.
  ingress_rules = local.sg2_ingress_rules        # The ingress rules for the security group, sourced from a local variable.
  egress_rules  = local.sg2_egress_rules         # The egress rules for the security group, sourced from a local variable.
  depends_on    = [module.sg1]  
}

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

# Outputs the web address for the deployed virtual machine.
output "web_address" {
  description = "The public address of the web server"
  value       = "http://${module.vm1.info.public_ip}:8080"
}