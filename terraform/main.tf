provider "aws" {
  region = "ap-south-1"
}

# Security Group
resource "aws_security_group" "devops_sg" {
  name        = "devops-masterclass-sg"
  description = "Security group for DevOps Masterclass"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Application Port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Jenkins"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-masterclass-sg"
  }
}

# EC2 Instance
resource "aws_instance" "devops_server" {
  ami                    = "ami-0912f71e06545ad88"
  instance_type          = "t3.micro"
  key_name               = "Siva-Class-Mumbai"
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  tags = {
    Name = "DevOps-Masterclass-Server-02"
  }
}

# Output Public IP
output "public_ip" {
  value = aws_instance.devops_server.public_ip
}