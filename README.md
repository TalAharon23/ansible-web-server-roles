# Deploying Web Server with Terraform and Ansible

Welcome to the guide for setting up a web server on AWS using Terraform and Ansible. This guide will walk you through each step, from setting up your environment to deploying the web server and cleaning up afterward.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Provision web-app environment](#Provision-web-app-environment)
- [Configure Ansible and Run Playbook](#configure-ansible-and-run-playbook)
- [Access Web Server](#access-web-server)
- [Cleaning Up](#cleaning-up)
- [Additional Notes](#additional-notes)

## Prerequisites

Before you start, make sure you have the following tools and resources:

- AWS Account with API Credentials
- Terraform Installed (>=0.12)
- Ansible Installed (>=2.9)
- SSH Key Pair for EC2 Instances
- Basic understanding of AWS, Terraform, and Ansible

## Setup

1. Clone the Repository into the /etc/ansible directory

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

3. Generate and Set Up EC2 Key Pair **with the name ec2key**, then add it to the repo directory.


## Provision web-app environment

1. Navigate to the Ansible Directory

   ```bash
   cd /etc/ansible/
   ```

2. Provision web-app environment:

   ```bash
   ./deploy_webserver.sh
   ```

**Pay attention:** All web-app environment will be deployed at us-east-1 region. 

## Access Web Server

After the Ansible playbook completes successfully, you can access the web server by entering the public IP address of the EC2 instance in a web browser and see the output:


<img width="380" alt="image" src="https://github.com/TalAharon23/ansible-web-server-roles/assets/82831070/89d08baa-227c-4f40-8ade-2524baff3b0d">


## Cleaning Up
Run the following command from the /etc/ansible directory:

   ```bash
   ./destroy_webserver.sh
   ```
