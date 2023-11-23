##############################################
### Modules for the deployment of the resources
##############################################

##############################################
### Create Key Pairs
##############################################
module "key" {
    count = length(local.ec2_key_names)
  source = "../../modules/ec2/key_pair" 
  name   = local.ec2_key_names[count.index]     
  key    = local.ec2_key_keys[count.index]           
}

##############################################
### Create VPCs
##############################################
module "virtual_private_cloud" {
    count = length(local.vpc_virtual-private-cloud_names)
  source = "../../modules/vpc/virtual_private_cloud" 
  name   = local.vpc_virtual-private-cloud_names[count.index]    
  cidr   = local.vpc_virtual-private-cloud_cidrs[count.index]  
}

##############################################
### Create Subnets
##############################################
module "subnet" {
    count = length(local.vpc_subnet_names)
  source            = "../../modules/vpc/subnet"       
  name              = local.vpc_subnet_names[count.index]              
  cidr              = local.vpc_subnet_cidrs[count.index]  
  availability_zone = local.vpc_subnet_availability-zones[count.index]         
  vpc_id            = module.virtual_private_cloud[0].info.id          
  depends_on = [
    module.virtual_private_cloud[0]
  ]
}

##############################################
### Create Security Groups
##############################################
module "security_group" {
    count = length(local.ec2_security-group_names)
  source        = "../../modules/ec2/security_group"
  vpc_id        = module.virtual_private_cloud[0].info.id           
  name          = local.ec2_security-group_names[count.index]           
  description   = local.ec2_security-group_descriptions[count.index]        
  ingress_rules = local.ec2_security-group_ingress_rules[count.index]   
  egress_rules  = local.ec2_security-group_egress_rules[count.index]         
}

##############################################
### Create EC2 Instances
##############################################
module "virtual_machine" {
    count = length(local.ec2_virtual-machine_names)
  source          = "../../modules/ec2/virtual_machine"
  name            = local.ec2_virtual-machine_names[count.index]               
  image           = local.ec2_virtual-machine_images[count.index]              
  type            = local.ec2_virtual-machine_types[count.index]              
  disk_size       = local.ec2_virtual-machine_disk_sizes[count.index]        
  disk_type       = local.ec2_virtual-machine_disk_types[count.index]           
  subnet_id       = module.subnet[0].info.id           
  key_pair        = local.ec2_key_names[0]          
  security_groups = module.security_group[0].info.id          
  ssh_user        = local.ec2_virtual-machine_ssh_users[count.index]             
  depends_on      = [module.subnet, module.key]     
}