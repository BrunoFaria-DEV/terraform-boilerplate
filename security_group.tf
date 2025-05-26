resource "aws_security_group" "allow_tls_ssh" {
  name        = "allow_tls_ssh"
  description = "Allow TLS and SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls_ssh"
  }
}

### --- INGRESS (ENTRADA) ---

# TLS (HTTPS) - IPv4 dentro da VPC
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls_ssh.id
  cidr_ipv4         = aws_vpc.main.cidr_block
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# TLS (HTTPS) - IPv6 dentro da VPC
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls_ssh.id
  cidr_ipv6         = aws_vpc.main.ipv6_cidr_block
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# SSH - Acesso externo via IPv4 (público)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_tls_ssh.id
  cidr_ipv4         = "0.0.0.0/0"  # Pode trocar por seu IP: ex. "200.100.50.25/32"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# SSH - Acesso externo via IPv6 (opcional)
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv6" {
  security_group_id = aws_security_group.allow_tls_ssh.id
  cidr_ipv6         = "::/0"  # Pode trocar por um bloco específico
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

### --- EGRESS (SAÍDA) ---

# Libera todo tráfego de saída - IPv4
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls_ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# Libera todo tráfego de saída - IPv6
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls_ssh.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}