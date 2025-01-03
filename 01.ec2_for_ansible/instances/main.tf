variable "vpc_id" {}
variable "subnet_id" {}
variable "security_group_id" {}

resource "aws_instance" "devops" {
  count         = 2
  ami           = "ami-0e2c8caa4b6378d8c"  # Replace with the latest Ubuntu AMI ID for your region
  instance_type = "t2.micro"
  key_name      = "devops"
  subnet_id     = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "devops${count.index + 1}"
  }

  vpc_security_group_ids = [var.security_group_id]
}

#This can also show the output of public ip
# output "public_ip" {
#   value = aws_instance.devops[*].public_ip
# }

