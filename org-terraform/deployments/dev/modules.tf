##############################################
### Modules for the deployment of the resources
##############################################

##############################################
### Create Key Pairs
##############################################
module "key" {
  count  = length(local.ec2_key_names)      # Number of key pairs
  source = "../../modules/ec2/key_pair"     # Path to the module
  name   = local.ec2_key_names[count.index] # Key pair name
  key    = local.ec2_key_keys[count.index]  # Public key for key pair
}

##############################################
### Create VPCs
##############################################
module "virtual_private_cloud" {
  count  = length(local.vpc_virtual-private-cloud_names)      # Number of VPCs
  source = "../../modules/vpc/virtual_private_cloud"          # Path to the module
  name   = local.vpc_virtual-private-cloud_names[count.index] # VPC name
  cidr   = local.vpc_virtual-private-cloud_cidrs[count.index] # VPC CIDR block
}

##############################################
### Create Subnets
##############################################
module "subnet" {
  count             = length(local.vpc_subnet_names)                   # Number of subnets
  source            = "../../modules/vpc/subnet"                       # Path to the module
  name              = local.vpc_subnet_names[count.index]              # Subnet name
  cidr              = local.vpc_subnet_cidrs[count.index]              # Subnet CIDR block
  availability_zone = local.vpc_subnet_availability-zones[count.index] # Subnet availability zone
  vpc_id            = module.virtual_private_cloud[0].info.id          # VPC ID
  depends_on = [
    module.virtual_private_cloud[0]
  ]
}

##############################################
### Create Security Groups
##############################################
module "security_group" {
  count         = length(local.ec2_security-group_names)              # Number of security groups
  source        = "../../modules/ec2/security_group"                  # Path to the module
  name          = local.ec2_security-group_names[count.index]         # Security group name
  description   = local.ec2_security-group_descriptions[count.index]  # Security group description
  ingress_rules = local.ec2_security-group_ingress_rules[count.index] # Security group ingress rules
  egress_rules  = local.ec2_security-group_egress_rules[count.index]  # Security group egress rules
  vpc_id        = module.virtual_private_cloud[0].info.id             # VPC ID
}

##############################################
### Create EC2 Instances
##############################################
module "virtual_machine" {
  count           = length(local.ec2_virtual-machine_names)           # Number of EC2 instances
  source          = "../../modules/ec2/virtual_machine"               # Path to the module
  name            = local.ec2_virtual-machine_names[count.index]      # EC2 instance name
  image           = local.ec2_virtual-machine_images[count.index]     # EC2 instance image
  type            = local.ec2_virtual-machine_types[count.index]      # EC2 instance type
  disk_size       = local.ec2_virtual-machine_disk_sizes[count.index] # EC2 instance disk size
  disk_type       = local.ec2_virtual-machine_disk_types[count.index] # EC2 instance disk type
  ssh_user        = local.ec2_virtual-machine_ssh_users[count.index]  # EC2 instance SSH user
  subnet_id       = module.subnet[0].info.id                          # Subnet ID
  key_pair        = local.ec2_key_names[0]                            # Key pair name
  security_groups = module.security_group[0].info.id                  # Security group ID
  depends_on      = [module.subnet, module.key]
}