# 🚀 Terraform AWS Boilerplate - Simple EC2 Instance

Este repositório contém um boilerplate padrão para criar **instâncias EC2 simples na AWS** utilizando Terraform. A estrutura é ideal para quem está começando com infraestrutura como código (IaC) ou quer uma base reutilizável e minimalista para projetos em nuvem com a AWS.

---

## 📦 Requisitos

- [Terraform v1.6+](https://developer.hashicorp.com/terraform/downloads)  
- Conta ativa na [AWS](https://aws.amazon.com/)
- Chave de acesso e segredo configurados ou definidos via variáveis

---

## 🛠️ Instalação

1. Clone o repositório:
   ```bash
   git clone https://github.com/seu-usuario/terraform-boilerplate.git
   cd terraform-boilerplate
   ```

2. Crie um arquivo `variables.tf` com base no `variable_example.tf`:

   ```bash
   cp variable_example.tf variables.tf
   ```

3. Edite o `variables.tf` e substitua os valores conforme sua configuração AWS e preferências de instância:

   ```hcl
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
     default = "nome_da_sua_chave_ssh"
     type    = string
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
   ```

---

## 🚀 Comandos para subir a infraestrutura

1. Inicialize o Terraform (instala os providers e prepara o ambiente):

   ```bash
   terraform init
   ```

2. Visualize o que será criado:

   ```bash
   terraform plan
   ```

3. Aplique a infraestrutura:

   ```bash
   terraform apply
   ```

---

## 🧯 Para destruir a infraestrutura criada

```bash
terraform destroy
```

---

## 📁 Estrutura do projeto

```bash
.
├── main.tf             # Regras principais de infraestrutura
├── outputs.tf          # Saídas da execução (como IP da instância)
├── provider.tf         # Provider AWS + autenticação
├── variables.tf        # Definição das variáveis (baseado em variable_example.tf)
├── variable_example.tf # Exemplo de configuração de variáveis
└── README.md           # Este arquivo
```

---

## 🔐 Sobre a chave SSH

A variável `key_name` deve corresponder ao **nome de uma chave pública já registrada na AWS (EC2 > Key Pairs)**. Isso permitirá acesso via SSH à instância criada.

Caso ainda não tenha uma chave:

* Gere uma com `ssh-keygen`
* Registre a pública (.pub) no painel da AWS
* Use o nome da chave na variável `key_name`

---

## 📚 Referências

* [Terraform AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
* [Documentação oficial do Terraform](https://developer.hashicorp.com/terraform/docs)

---

## 📄 Licença

MIT License

Copyright (c) 2025 Bruno

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell    
copies of the Software, and to permit persons to whom the Software is        
furnished to do so, subject to the following conditions:                     

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.                              

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR   
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,     
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER       
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
