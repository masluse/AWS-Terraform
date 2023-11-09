# Use the 'key_pair' module to provision a key pair with the defined properties.
module "key1" {
  source = "../../modules/key_pair" # Relative path to the key_pair module.
  name   = local.key1_name          # The name of the key pair
  key    = local.key1_key           # The public ssh key for the key pair
}

# Use the 'vpc' module to provision a VPC with the defined properties.
module "vpc1" {
  source = "../../modules/vpc" # Relative path to the vpc module.
  name   = local.vpc1_name     # The name of the vpc
  cidr   = local.vpc1_cidr     # The cidr of the vpc
}

# Use the 'subnet' module to provision a subnet with the defined properties.
module "sub1" {
  source = "../../modules/subnet" # Relative path to the subnet module.
  name   = local.sub1_name        # The name of the subnet.
  cidr   = local.sub1_cidr        # The cidr of the subnet.
  vpc_id = module.vpc1.info.id    # The VPC id where the subnet should be created at.
  availability_zone = local.sub1_availability_zone
  depends_on = [
    module.vpc1
  ]
}

# Use the 'subnet' module to provision a subnet with the defined properties.
module "sub2" {
  source  = "../../modules/subnet" # Relative path to the subnet module.
  name    = local.sub2_name        # The name of the subnet.
  cidr    = local.sub2_cidr        # The cidr of the subnet.
  vpc_id  = module.vpc1.info.id    # The VPC id where the subnet should be created at.
  private = true                   # Boolean that the subnet should be private (default is false).
  availability_zone = local.sub2_availability_zone
  depends_on = [
    module.vpc1
  ]
}

# Use the 'subnet' module to provision a subnet with the defined properties.
module "sub3" {
  source  = "../../modules/subnet" # Relative path to the subnet module.
  name    = local.sub3_name        # The name of the subnet.
  cidr    = local.sub3_cidr        # The cidr of the subnet.
  vpc_id  = module.vpc1.info.id    # The VPC id where the subnet should be created at.
  private = true                   # Boolean that the subnet should be private (default is false).
  availability_zone = local.sub3_availability_zone
  depends_on = [
    module.vpc1
  ]
}

module "sg1" {
  source        = "../../modules/security-group"
  vpc_id        = module.vpc1.info.id
  name          = local.sg1_name
  description   = local.sg1_description
  ingress_rules = local.sg1_ingress_rules
  egress_rules  = local.sg1_egress_rules
}

module "sg2" {
  source        = "../../modules/security-group"
  vpc_id        = module.vpc1.info.id
  name          = local.sg2_name
  description   = local.sg2_description
  ingress_rules = local.sg2_ingress_rules
  egress_rules  = local.sg2_egress_rules
}

resource "aws_db_subnet_group" "private" {
  name       = "db_subnet_group"
  subnet_ids = [module.sub2.info.id, module.sub3.info.id]
  depends_on = [ module.sub2, module.sub3 ]
}

module "rds1" {
  source                 = "../../modules/rds"
  storage                = local.rds1_storage
  db_name                = local.rds1_db_name
  engine                 = local.rds1_engine
  engine_version         = local.rds1_engine_version
  instance_class         = local.rds1_instance_class
  username               = local.rds1_username
  password               = local.rds1_password
  vpc_security_group_ids = module.sg2.info.id
  db_subnet_group_name   = aws_db_subnet_group.private.name
  depends_on = [ aws_db_subnet_group.private ]
}

module "vm1" {
  source          = "../../modules/virtual-machine" # Relative path to the virtual-machine module.
  name            = local.vm1_name                  # The name of the Virtual Machine
  image           = local.vm1_image                 # The image of the Virtual Machine
  type            = local.vm1_type                  # The VM-Type of the Virtual Machine
  disk_size       = local.vm1_disk_size             # The disk size of the Virtual Machine
  disk_type       = local.vm1_disk_type             # The disk type of the Virtual Machine
  subnet_id       = module.sub1.info.id             # The subnet in which the Virtual Machine should be placed in.
  key_pair        = local.key1_name                 # The ssh key the Virtual Machine should use.
  security_groups = module.sg1.info.id
  ssh_user = local.vm1_ssh_user
  depends_on = [
    module.sub1, module.key1
  ]
}


output "web_address" {
  description = "The public address of the web server"
  value       = "http://" + module.vm1.info.public_ip + ":8080"
}

module "ansible1" {
  source = "../../modules/ansible"
  path_to_script = "../../scripts/ansible/ansible.yaml"
  public_ip = module.vm1.info.public_ip
  private_key_path = local.private_key_path
  ansible_extra_vars = {
  username = local.rds1_username,
  password = local.rds1_password,
  endpoint = module.rds1.info.address,
  port = module.rds1.info.port
  }
  depends_on = [ module.vm1, module.rds1 ]
}