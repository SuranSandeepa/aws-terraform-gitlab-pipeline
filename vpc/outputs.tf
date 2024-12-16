output "public_subnet" {
  value = aws_subnet.public_subnet.id
}

output "public_sg" {
  value = aws_security_group.public_sg.id
}