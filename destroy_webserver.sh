#!/bin/bash

# Change to the directory where your Terraform configuration files are located
cd /etc/ansible

# Run Terraform destroy
read -p "🔴 Do you want to destroy the web-app? (yes/no): " confirm
if [[ $confirm == "yes" ]]; then
    echo "🔥 Starting to destroy web-app environment"
else
    echo "❌ Aborting environment destruction..."
    exit 1
fi

# Run the Ansible playbook to remove the web server instance and related configurations
echo "🔧 About to destroy web-app instances using Ansible..."
ansible-playbook web-app.yml -e "state=absent"

# Run terraform destroy to destroy network
echo "🌐 Starting to destroy web-app network using Terraform..."
terraform destroy -auto-approve

# Display a message indicating successful destruction
echo "✅ Infrastructure destroyed successfully."
