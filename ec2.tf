resource "aws_instance" "app_server" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.exsisting.id]
  # Replace with your key pair name
  key_name      = "demoec"
  
 /*#root_block_device {
    volume_size = 30          # Size in GB
    volume_type = "gp3"       # General Purpose SSD (recommended)
    delete_on_termination = true
  }
  */ #Optionally, you can specify additional block devices if needed
  # e.g., for an additional EBS volume:
  
  tags = {
    Name = "ExampleAppServerInstance"
  }
}
