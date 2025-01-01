provider "aws" {
  region = "us-east-1" # Change to your desired region
}

module "network" {
  source = "./network"
}

module "instances" {
  source            = "./instances"
  vpc_id            = module.network.vpc_id
  subnet_id         = module.network.subnet_id
  security_group_id = module.network.security_group_id
}

#This is showing the output of public ip from main.tf from module
# output "instance_public_ips" {
#   value = module.instances.public_ip
# }

output "instance_public_ips" {
  value = module.instances.devops_public_ips
}