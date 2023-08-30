# Deploying Web Server with Terraform and Ansible

Welcome to the guide for setting up a web server on AWS using Terraform and Ansible. This guide will walk you through each step, from setting up your environment to deploying the web server and cleaning up afterward.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Provision Infrastructure with Terraform](#provision-infrastructure-with-terraform)
- [Configure Ansible and Run Playbook](#configure-ansible-and-run-playbook)
- [Access Web Server](#access-web-server)
- [Cleaning Up](#cleaning-up)
- [Variables and Configuration](#variables-and-configuration)
- [Additional Notes](#additional-notes)

## Prerequisites

Before you start, make sure you have the following tools and resources:

- AWS Account with API Credentials
- Terraform Installed (>=0.12)
- Ansible Installed (>=2.9)
- SSH Key Pair for EC2 Instances
- Basic understanding of AWS, Terraform, and Ansible

## Setup

1. Clone the Repository

   ```bash
   git clone https://github.com/TalAharon23/ansible-web-server-roles.git /etc/ansible
   cd /etc/ansible
   ```

2. Export AWS Credentials

    Export your AWS API credentials as environment variables to enable Terraform and Ansible to access your AWS account:
    ```bash
    export AWS_ACCESS_KEY_ID="your_access_key"
    export AWS_SECRET_ACCESS_KEY="your_secret_key"
    ```

3. Generate and Set Up the EC2 Key Pair, then add it to the repo directory.


## Provision Infrastructure with Terraform

1. Navigate to the Terraform Directory

   ```bash
   cd /etc/ansible/ansible-web-server-role 
   ```

2. terraform init

    ```bash
    terraform init
    ```


3. Review and Apply the Plan

   Review the plan to ensure it aligns with your expectations:
   ```bash
    terraform plan
    ```

   Apply the plan to create the AWS infrastructure:
   ```bash
   terraform apply
   ```

## Configure Ansible and Run Playbook

1. Navigate to the Ansible Directory

   ```bash
   cd /etc/ansible/ansible-web-server-roles
   ```

2. Set the playbook variables:

| Variable           | Value              | Required | Default       | Description                                          |
|--------------------|--------------------|----------|---------------|------------------------------------------------------|
| my_ip              | string             | Yes      | -----         | Your local IP for inbound rules and ssh connection   |
| ec2key             | string             | Yes      | -----         | Name of the EC2 key pair                            |
| vpc_id             | string             | Yes      | vpc-XXXXXXX   | VPC id got from terraform apply |
| subent_id          | string             | Yes      | subnet-XXXXXX | Subnet id got from terraform apply |
| region             | string             | No       | us-east-1     | AWS region                                           |
| instance_type      | string             | No       | t2.micro      | EC2 instance type                                   |
| ami_id             | string             | No       | ami-08a52ddb321b32a8c         | ID of the Amazon Linux AMI for EC2  |
| sg_name            | string             | No      | web-app-sg     | AWS Security group name |
| tag_name           | string             | No       | webserver     | Tag name for webserver for connecting the ec2's      |
| count              | integer            | No       | 1             | Number of web-servers to deploy |

Edit the playbook web-app.yml file e.g.


<img width="760" alt="image" src="https://github.com/TalAharon23/ansible-web-server-roles/assets/82831070/723da705-9ddd-45b9-a9db-772cb8f39aad">




2. Run the Ansible playbook:

    ```bash
    ansible-playbook web-app.yml

## Access Web Server

After the Ansible playbook completes successfully, you can access the web server by entering the public IP address of the EC2 instance in a web browser and see the output:


<img width="380" alt="image" src="https://github.com/TalAharon23/ansible-web-server-roles/assets/82831070/89d08baa-227c-4f40-8ade-2524baff3b0d">



## Cleaning Up
Run the followin command from the /etc/ansible directory:

    ```bash
    ./destroy_webserver.sh

