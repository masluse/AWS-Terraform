# Use the 'virtual-machine' module to provision a VM instance with the defined properties.
module "vpc1" {
  source = "../../modules/vpc" # Relative path to the virtual machine module.
  name   = local.vpc1_name     # The name of the VM instance.
  cidr   = local.vpc1_cidr
}

module "sub1" {
  source = "../../modules/subnet" # Relative path to the virtual machine module.
  name   = local.sub1_name        # The name of the VM instance.
  cidr   = local.sub1_cidr
  vpc_id = module.vpc1.info.id
  depends_on = [
    module.vpc1
  ]
}

module "sub2" {
  source  = "../../modules/subnet" # Relative path to the virtual machine module.
  name    = local.sub2_name        # The name of the VM instance.
  cidr    = local.sub2_cidr
  vpc_id  = module.vpc1.info.id
  private = true
  depends_on = [
    module.vpc1
  ]
}

module "nat1" {
  source          = "../../modules/nat-instance"
  name            = "test"
  subnet_id_place = module.sub1.info.id
  subnet_id_route = module.sub2.info.id
  vpc_id          = module.vpc1.info.id
  depends_on = [
    module.vpc1, module.sub1
  ]
}

module "key1" {
  source          = "../../modules/key_pair"
  name            = local.key1_name
  key = local.key1_key
}

module "vm1" {
  source    = "../../modules/virtual-machine"
  name      = local.vm1_name
  image     = local.vm1_image
  type      = local.vm1_type
  disk_size = local.vm1_disk_size
  disk_type = local.vm1_disk_type
  subnet_id = module.sub1.info.id
  key_pair = local.key1_name
  depends_on = [
    module.sub1, module.key1
  ]
}

module "vm2" {
  source    = "../../modules/virtual-machine"
  name      = local.vm2_name
  image     = local.vm2_image
  type      = local.vm2_type
  disk_size = local.vm2_disk_size
  disk_type = local.vm2_disk_type
  subnet_id = module.sub2.info.id
  key_pair = local.key1_name
  depends_on = [
    module.sub2, module.key1
  ]
}