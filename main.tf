terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = "${var.aws-region}"
}


resource "aws_instance" "terraform" {
  ami           = "ami-055d15d9cfddf7bd3"
  security_groups = ["${aws_security_group.web-sg.name}"]
  instance_type = "t2.micro"
  key_name 		= "demokey"


tags = {
    Name = "terraform Demo"
  }
}  

resource "aws_security_group" "web-sg" {
  name        = "webserver-sg"
  description = "Security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}