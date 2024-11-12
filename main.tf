provider "aws" {
  region = "us-east-1"
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block    = "10.0.0.0/16"
  private_subnet    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnet     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# NAT Gateway Module
module "nat_gateway" {
  source = "./modules/nat_gateway"

  public_subnet_id = module.vpc.public_subnet_ids[0] # Attach NAT Gateway to the first public subnet
}

# Route Tables Module
module "route_tables" {
  source = "./modules/route_tables"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids  # Pass the public subnet IDs
  private_subnet_ids = module.vpc.private_subnet_ids # Pass the private subnet IDs


  internet_gateway_id = module.vpc.internet_gateway_id    # Use the Internet Gateway from the VPC module
  nat_gateway_id      = module.nat_gateway.nat_gateway_id # Use NAT Gateway ID from NAT Gateway module
}

# EC2 Module
module "ec2" {
  source = "./modules/ec2"

  public_instance_ami   = "ami-005fc0f236362e99f"          # AMI for public instance
  private_instance_ami  = "ami-055a0bf7c6225776d"          # AMI for private instance
  public_instance_type  = "t2.micro"                       # Instance type for public instance
  private_instance_type = "t2.micro"                       # Instance type for private instance
  public_subnet_id      = module.vpc.public_subnet_ids[0]  # Use first public subnet
  private_subnet_id     = module.vpc.private_subnet_ids[0] # Use first private subnet
  key_pair              = "my-ec2-key"

  # Pass security group IDs
  public_instance_sg_id  = module.security_group.public_instance_sg_id
  private_instance_sg_id = module.security_group.private_instance_sg_id
}

# Security Group Module
module "security_group" {
  source = "./modules/security_group"

  vpc_id = module.vpc.vpc_id
}

# Elastic IP for NAT Gateway (if not already included in NAT Gateway module)
resource "aws_eip" "nat" {
  vpc = true
}
