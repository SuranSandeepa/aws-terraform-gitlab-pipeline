#ec2

resource "aws_instance" "web_server" {
  ami = "ami-0e2c8caa4b6378d8c"
  instance_type = "t2.micro"
  subnet_id = var.public_subnet_id
  security_groups = [var.security_group_id] # Fix: Wrap it in brackets

  tags = {
    Name = "susanserver"
  }
}