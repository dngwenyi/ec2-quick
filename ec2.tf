terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "east-us-2" # Replace with your desired region
}

resource "aws_security_group" "sg" {
  name_prefix = "della-sg"

  // Allow incoming SSH and HTTP traffic
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
}

resource "aws_instance" "ec2" {
  ami           = "ami-053b0d53c279acc90"    # Replace with your desired AMI ID
  instance_type = "t2.micro"                 # Replace with your desired instance type
  key_name      = "man-ibt-review" # Replace with your key pair name

  security_groups = [aws_security_group.sg.name]

  tags = {
    Name = "Prod-instance"
  }
}

output "instance_id" {
  value = aws_instance.ec2.id
}

output "instance_public_ip" {
  value = aws_instance.ec2.public_ip
}
