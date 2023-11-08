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
  depends_on = [
    module.vpc1
  ]
}

# Use the 'nat-instance' module to provision a NAT Instance with the defined properties.
module "nat1" {
  source          = "../../modules/nat-instance" # Relative path to the nat-instance module.
  name            = local.nat1_name              # The name of the NAT Instance.
  subnet_id_place = module.sub1.info.id          # The subnet where the NAT Instance should be created in.
  subnet_id_route = module.sub2.info.id          # The subnet which should route all external traffic to the NAT Instance
  vpc_id          = module.vpc1.info.id          # The VPC id of the VPC in which the NAT Instance should be
  depends_on = [
    module.vpc1, module.sub1
  ]
}

# Use the 'key_pair' module to provision a key pair with the defined properties.
module "key1" {
  source = "../../modules/key_pair" # Relative path to the key_pair module.
  name   = local.key1_name          # The name of the key pair
  key    = local.key1_key           # The public ssh key for the key pair
}

# Use the 'virtual-machine' module to provision a Key Pair with the defined properties.
module "vm1" {
  source    = "../../modules/virtual-machine" # Relative path to the virtual-machine module.
  name      = local.vm1_name                  # The name of the Virtual Machine
  image     = local.vm1_image                 # The image of the Virtual Machine
  type      = local.vm1_type                  # The VM-Type of the Virtual Machine
  disk_size = local.vm1_disk_size             # The disk size of the Virtual Machine
  disk_type = local.vm1_disk_type             # The disk type of the Virtual Machine
  subnet_id = module.sub1.info.id             # The subnet in which the Virtual Machine should be placed in.
  key_pair  = local.key1_name                 # The ssh key the Virtual Machine should use.
  depends_on = [
    module.sub1, module.key1
  ]
}

# Use the 'virtual-machine' module to provision a Key Pair with the defined properties.
module "vm2" {
  source    = "../../modules/virtual-machine" # Relative path to the virtual-machine module.
  name      = local.vm2_name                  # The name of the Virtual Machine
  image     = local.vm2_image                 # The image of the Virtual Machine
  type      = local.vm2_type                  # The VM-Type of the Virtual Machine
  disk_size = local.vm2_disk_size             # The disk size of the Virtual Machine
  disk_type = local.vm2_disk_type             # The disk type of the Virtual Machine
  subnet_id = module.sub2.info.id             # The subnet in which the Virtual Machine should be placed in.
  key_pair  = local.key1_name                 # The ssh key the Virtual Machine should use.
  depends_on = [
    module.sub2, module.key1
  ]
}