# Security Group for Public Instance
resource "aws_security_group" "public_instance_sg" {
  vpc_id = var.vpc_id
  description = "Security group for public instance with SSH and internet access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_allowed_ips  
    description = "Rules"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.ssh_allowed_ips
    description = "Rules"
  }

  tags = {
    Name = "Public Instance SG"
  }

  # checkov:skip=CKV2_AWS_5
}

# Security Group for Private Instance
resource "aws_security_group" "private_instance_sg" {
  vpc_id = var.vpc_id
  description = "Security group for private instance with SSH and internet access"

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_instance_sg.id] 
    description = "Rules"
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_instance_sg.id] 
    description = "Rules"
  }

  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = [aws_security_group.public_instance_sg.id] 
    description = "Rules"
  }

  tags = {
    Name = "Private Instance SG"
  }

  # checkov:skip=CKV2_AWS_5
}