# AWS Multi-Environment Infrastructure with Terraform Workspaces

This project demonstrates how to build and manage a scalable, multi-environment AWS infrastructure using a single codebase. It utilizes **Terraform Workspaces** and conditional logic to deploy environment-specific configurations for development, staging, and production.

## 🚀 Key Features

*   **Terraform Workspaces:** Uses `dev`, `staging`, and `prod` workspaces to logically separate environments without duplicating code.
*   **Locals & Map Lookups:** Uses a centralized `locals.tf` to map environment names directly to specific configuration values (instance counts, monitoring flags, CIDR ranges).
*   **Conditionals (`count`):** Conditionally creates resources depending on the environment. For example, a NAT Gateway is only provisioned in the `prod` workspace.
*   **Dynamic Blocks (`for_each`):** Dynamically builds security group ingress rules based on environment guidelines (e.g., dev/staging allows SSH, prod blocks it).
*   **Modular Architecture:** Infrastructure is broken down into reusable `vpc`, `security_group`, and `ec2` modules.

## 📁 Project Structure

```text
aws-multi-env-workspaces/
├── main.tf                 # Root module configuration and resource calls
├── variables.tf            # Input variable declarations
├── outputs.tf              # Important exported attributes (e.g., IPs, IDs)
├── locals.tf               # Environment-based mappings and configuration rules
├── terraform.tfvars        # Values for required variables (like region, AMI)
└── modules/
    ├── ec2/                # Instances, SSH Key generation, Elastic IPs
    ├── security_group/     # Security Groups, Dynamic Ingress/Egress rules
    └── vpc/                # VPC, Subnets, Internet/NAT Gateways, Route Tables
```

## 🛠️ Prerequisites

*   [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.0.0+)
*   [AWS CLI](https://aws.amazon.com/cli/) configured with valid programmatic access credentials.

## 🚦 Usage Instructions

### 1. Initialize Terraform
Run the initial setup to download the required AWS provider and prepare the modules:
```bash
terraform init
```

### 2. Create Workspaces
Configure the three required workspaces:
```bash
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
```

### 3. Deploy Dev Environment
Switch to the `dev` workspace to deploy a single EC2 instance (with no monitoring) that allows SSH.
```bash
terraform workspace select dev
terraform apply
```

### 4. Deploy Prod Environment
Switch to the `prod` workspace to scale to 3 instances, enable detailed CloudWatch monitoring, launch a NAT Gateway, and restrict SSH access.
```bash
terraform workspace select prod
terraform apply
```

### 5. Cleanup
To destroy infrastructure from a workspace, select it and run destroy:
```bash
terraform workspace select dev
terraform destroy

terraform workspace select prod
terraform destroy
```

## 🧠 Workspaces vs. Separate State Files
What is the best way to handle multiple environments?

*   **Workspaces:** Excellent for managing near-identical environments (like Staging vs. QA) from the same repository to avoid code duplication. However, all workspaces use the exact same state backend configurations—requiring careful discipline to ensure production is not accidentally targeted.
*   **Separate State Files / Repositories:** Ideal when security, network boundaries, and state backends must be completely isolated between environments (e.g., Sandbox vs. Prod). It introduces code duplication but heavily insulates environments from each other.
