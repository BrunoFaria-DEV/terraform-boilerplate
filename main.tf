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

  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true

  tags = {
    Name = "public_instance"
  }
}




resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}