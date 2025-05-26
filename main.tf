terraform {
  required_version = "1.12.1"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_instance_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# RSA key of size 4096 bits
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Registrar a chave pública na AWS
resource "aws_key_pair" "key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

# Salvar private key localmente
resource "local_file" "private_key" {
  content = tls_private_key.rsa_4096.private_key_pem
  filename = "${var.key_name}.pem"
  file_permission = "0400"
}

resource "aws_instance" "public_instance" {
  ami = var.ami_type
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
  
  vpc_security_group_ids = [aws_security_group.allow_tls_ssh.id]

  tags = {
    Name = "public_instance"
  }
}
