#!/bin/bash

sudo chmod -R 755 .

# Install Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y

# Install Ansible
sudo apt update
sudo apt upgrade -y
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt update
sudo apt install ansible -y

# Downloads the CLI based on your OS/arch and puts it in /usr/local/bin
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
infracost auth login

# Install Extensions on the code server
code --install-extension 4ops.terraform
code --install-extension hashicorp.terraform
code --install-extension redhat.ansible
code --install-extension github.copilot 

echo "Installation completed."