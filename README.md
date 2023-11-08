# AWS-Terraform
## Overview
This Terraform project consists of the configuration and deployment of cloud infrastructure resources. It includes the creation of Key pairs, NAT Instances, Virtual Machines, vpc and subnets within a cloud project.
## Modules at a Glance
- Key pairs: Configures a key pair for a virtual machine.
- NAT Instance: Configures a NAT Instance that NATs traffic to the Internet.
- Virtual Machine: Creates a virtual machine (VM).
- VPC: Provisions a vpc (Virtual Private Cloud).
- Subnets: Creates a subnet inside of a vpc
## Requirements
Terraform installed (version 1.6 or higher)
Access credentials for the cloud environment (~/.aws/credentials)
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
## Usage of the Modules
1. key_pair
    ```
    # Use the 'key_pair' module to provision a key pair with the defined properties.
    module "key1" {
    source = "../../modules/key_pair" # Relative path to the key_pair module.
    name   = local.key1_name          # The name of the key pair
    key    = local.key1_key           # The public ssh key for the key pair
    }
    ```
2. nat-instance
    ```
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
    ```
3. virtual-machine
    ```
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
    ```
4. vpc
    ```
    # Use the 'vpc' module to provision a VPC with the defined properties.
    module "vpc1" {
    source = "../../modules/vpc" # Relative path to the vpc module.
    name   = local.vpc1_name     # The name of the vpc
    cidr   = local.vpc1_cidr     # The cidr of the vpc
    }
    ```
5. subnet
    ```
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
    ```


