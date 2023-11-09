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

# Initializes a module for creating a security group within the specified VPC.
module "sg1" {
  source        = "../../modules/security-group" # The path to the security group module's source code.
  vpc_id        = module.vpc1.info.id            # The ID of the VPC where the security group will be created.
  name          = local.sg1_name                 # The name for the security group, sourced from a local variable.
  description   = local.sg1_description          # The description for the security group, sourced from a local variable.
  ingress_rules = local.sg1_ingress_rules        # The ingress rules for the security group, sourced from a local variable.
  egress_rules  = local.sg1_egress_rules         # The egress rules for the security group, sourced from a local variable.
}

# This module invocation creates a virtual machine instance with specified configurations.
module "vm1" {
  source          = "../../modules/virtual-machine" # Module source path
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

module "disk1" {
  source            = "../../modules/disks" # Relative path to the virtual-machine module.
  name              = local.disk1_name
  availability_zone = module.vm1.info.availability_zone
  device_name       = local.disk1_device_name
  size              = local.disk1_size
  type              = local.disk1_type
  aws_instance_id   = module.vm1.info.id
  depends_on = [
    module.vm1
  ]
}

# This module is used to run Ansible playbooks against a provisioned VM for configuration management.
module "ansible1" {
  source           = "../../modules/ansible"              # Location of the Ansible module
  path_to_script   = "../../scripts/ansible/disk_add.yaml" # Path to the Ansible playbook file
  public_ip        = module.vm1.info.public_ip            # The public IP address of the provisioned VM
  private_key_path = local.private_key_path               # The path to the SSH private key for Ansible to use
  ansible_extra_vars = {                                  # Extra variables to pass to Ansible
    name = local.disk1_name,                       # Username for RDS instance
    pvs = local.disk1_device_name
  }
  depends_on = [module.vm1, module.disk1]  # Ensures Ansible runs after VM is provisioned
}

# Outputs the web address for the deployed virtual machine.
output "IP-address" {
  description = "The public ip address of the server"
  value       = "ssh ubuntu@${module.vm1.info.public_ip}"
}