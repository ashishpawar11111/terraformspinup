terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  # Replace with your key pair name
  key_name      = "demoec"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# Output block to show public IP
output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.app_server.public_ip
}
# Just a comment