# Connecting EC2 to RDS with Terraform

This repository contains Terraform configurations to set up a secure connection between an Amazon EC2 instance and an Amazon RDS database for WordPress deployment.

## Project Overview

This project demonstrates how to:

1. Configure AWS infrastructure using Terraform
2. Create a secure VPC with public and private subnets
3. Deploy an EC2 instance in a public subnet
4. Deploy an RDS MySQL database in a private subnet
5. Establish secure connectivity between EC2 and RDS
6. Install and configure WordPress on the EC2 instance

## Prerequisites

Before getting started, ensure you have:

- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0+)
- [AWS CLI](https://aws.amazon.com/cli/) installed and configured
- An AWS account with appropriate permissions
- Basic knowledge of AWS services (EC2, RDS, VPC, Security Groups)

## Architecture
![Alt text](ec2-rds-architecture.png)
The infrastructure consists of:

- **VPC**: Custom VPC with proper CIDR block allocation
- **Subnets**: 
  - Public subnets for EC2 instances
  - Private subnets for RDS database
- **EC2 Instance**: Running Amazon Linux 2 with WordPress
- **RDS Instance**: MySQL database optimized for WordPress
- **Security Groups**: Properly configured for secure access
- **IAM Roles**: Minimal permissions following principle of least privilege

## Directory Structure

```
.
├── output.tf        # Output definitions
├── provider.tf      # Provider configurations
├── vpc.tf           # VPC, subnet, and networking resources
├── ec2.tf           # EC2 instance and related resources
├── rds.tf           # RDS instance and related resources
├── sg.tf            # Security groups and IAM roles
└── README.md        # Project documentation
```

## Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/shefreddy/connect-EC2-to-RDS.git
cd connect-EC2-to-RDS
```

### 2. Configure Terraform Variables

Create a `terraform.tfvars` file to customize your deployment:

```hcl
aws_region     = "us-east-1"
instance_type  = "t2.micro"
db_instance    = "db.t3.micro"
db_name        = "wordpress"
db_username    = "admin"
# Add other variables as needed
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the Execution Plan

```bash
terraform plan
```

### 5. Apply the Configuration

```bash
terraform apply
```

When prompted, type `yes` to confirm deployment.

### 6. Access WordPress

After successful deployment, you can access WordPress using the EC2 instance's public IP:

```
http://<EC2_PUBLIC_IP>
```

The public IP address will be shown in Terraform outputs.

## Security Considerations

This project implements several security best practices:

- EC2 instances are placed in public subnets with access limited via security groups
- RDS instances are placed in private subnets with no direct public access
- Security groups are configured with minimal required access
- Database credentials are managed securely
- All communication between EC2 and RDS is encrypted

## Clean Up

To destroy all resources created by Terraform:

```bash
terraform destroy
```

When prompted, type `yes` to confirm.

## Customization

### Modifying WordPress Configuration

The WordPress installation is handled through a user data script in the EC2 instance. To customize the WordPress setup, edit the `user_data` section in `ec2.tf`.

### Changing RDS Configuration

To modify the RDS configuration (instance size, storage, etc.), update the corresponding variables in `variables.tf` and `terraform.tfvars`.

### Adjusting Network Architecture

The VPC and subnet CIDR blocks can be modified in `vpc.tf` and `terraform.tfvars`.

## Troubleshooting

### Common Issues

1. **EC2 can't connect to RDS**: Check security groups and route tables
2. **WordPress installation fails**: Verify user data script in EC2 instance
3. **Terraform fails to apply**: Ensure AWS credentials are configured correctly

### Logs and Debugging

- EC2 instance logs: `/var/log/cloud-init-output.log`
- WordPress logs: `/var/log/apache2/error.log` or `/var/log/httpd/error_log`

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- [Terraform](https://www.terraform.io/)
- [AWS](https://aws.amazon.com/)
- [WordPress](https://wordpress.org/)

### **Author: Freddy Shema**

**📌 GitHub Profile:** [Freddy Shema](https://github.com/shefreddy)
