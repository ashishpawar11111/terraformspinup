resource "aws_instance" "app_server" {
  ami           = "ami-0ec10929233384c7f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [data.aws_security_group.exsisting.id]
  # Replace with your key pair name
  key_name      = "demoec"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
