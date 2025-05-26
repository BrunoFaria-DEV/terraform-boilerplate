variable "aws_access_key" {
  default = "SUA_ACCESS_KEY"
  type    = string
}

variable "aws_secret_key" {
  default = "SEU_SECRET_KEY"
  type    = string
}

variable "aws_instance_region" {
  default = "us-east-2" # Região padrão
  type    = string
}

variable "key_name" {

}

variable "instance_type" {
  default = "t2.micro"
  type    = string
}

variable "ami_type" {
  default     = "ami-02da2f5b47450f5a8" # Debian 12 - x86_64 HVM
  type        = string
  description = "ID da imagem (AMI) a ser utilizada"
}
