# Public Instance
resource "aws_instance" "public_instance" {
  ami                         = var.public_instance_ami
  instance_type               = var.public_instance_type
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = false
  ebs_optimized               = true
  monitoring                  = true
  key_name                    = var.key_pair
  vpc_security_group_ids      = [var.public_instance_sg_id]

  tags = {
    "Name" = "Group 20 Public Instance"
  }



  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_tokens = "required"  # Enforces the use of IMDSv2 only
  }

  # checkov:skip=CKV2_AWS_41
}

# Private Instance
resource "aws_instance" "private_instance" {
  ami                     = var.private_instance_ami
  instance_type           = var.private_instance_type
  subnet_id               = var.private_subnet_id
  key_name                = var.key_pair
  ebs_optimized           = true
  monitoring              = true
  vpc_security_group_ids  = [var.private_instance_sg_id]

  tags = {
    "Name" = "Group 20 Private Instance"
  }

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_tokens = "required"  
  }

  # checkov:skip=CKV2_AWS_41
}
