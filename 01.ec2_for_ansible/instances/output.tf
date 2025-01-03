output "devops_public_ips" {
  value = aws_instance.devops[*].public_ip
}

