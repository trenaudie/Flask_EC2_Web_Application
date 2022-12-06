terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-west-3"
}

data "aws_vpc" "main" {
  id = var.vpc_id
}

resource "aws_instance" "webApp" {
  ami           = "ami-03b755af568109dc3"
  instance_type = "t2.micro" #free tier eligible
  vpc_security_group_ids = [aws_security_group.allowHttpSSH.id]
  key_name = aws_key_pair.key1.key_name

  tags = {
    Name = "FlaskInstance"
  }
}

#Building and locally saving key pair and storing the public key on AWS
resource "tls_private_key" "key1" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "foo" {
    content  = tls_private_key.key1.private_key_pem
    filename = "${path.module}/key1.pem"
}

resource "aws_key_pair" "key1" {
  key_name   = "key1"
  public_key = tls_private_key.key1.public_key_openssh
  }



resource "aws_security_group" "allowHttpSSH" {
  name        = "allowHttpSSH"
  description = "Allow SSH inbound traffic and HTTP"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP from Web"
    from_port        = 80 #default HTTP port range
    to_port          = 80 
    protocol         = "tcp"
    cidr_blocks      =  ["0.0.0.0/0"]
  }
    ingress {
    description      = "SSH with Key Pair"
    from_port        = 22 #default SSH port range
    to_port          = 22 
    protocol         = "tcp"
    cidr_blocks      =  ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}