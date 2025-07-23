provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "devops_app" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  user_data = file("${path.module}/../scripts/user_data.sh")


  vpc_security_group_ids = [aws_security_group.allow_http_new.id]

  tags = {
    Name = "DevOpsEC2Instance"
  }
}

resource "aws_security_group" "allow_http_new" {
  name        = "allow_http_new"
  description = "Allow HTTP traffic on port 80"

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
