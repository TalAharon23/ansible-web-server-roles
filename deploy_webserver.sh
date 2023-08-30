#!/bin/bash

cd /etc/ansible

# Step 1: Run Terraform init and plan
echo "🚀 Running Terraform init..."
terraform init
echo "📝 Running Terraform plan..."
terraform plan

# Step 2: Run Terraform apply
read -p "🔵 Do you want to apply the changes? (yes/no): " confirm
if [[ $confirm == "yes" ]]; then
    echo "🚀 Running Terraform apply..."
    terraform apply -auto-approve
else
    echo "❌ Aborting Terraform apply..."
    exit 1
fi

# Extract outputs from Terraform
vpc_id=$(aws ec2 describe-vpcs --filters "Name=tag:Name,Values=web-server-vpc" --query "Vpcs[0].VpcId" --output text --region us-east-1)
echo "🌐 VPC ID: $vpc_id"
subnet_id=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$vpc_id" --query "Subnets[0].SubnetId" --output text --region us-east-1)
echo "🌍 Subnet ID: $subnet_id"
my_ip=$(curl -s http://ifconfig.co)
echo "🔒 My IP Address: $my_ip"

# Step 3: Run Ansible playbook
echo "🔧 Running Ansible playbook..."
ansible-playbook -e "vpc_id=$vpc_id my_ip=$my_ip vpc_subnet_id=$subnet_id" web-app.yml

# Final message
echo "✅ Done! Your infrastructure is up and running."
