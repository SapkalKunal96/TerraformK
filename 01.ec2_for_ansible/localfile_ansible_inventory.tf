resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/inventory.tpl", {
    public_ips = module.instances.devops_public_ips,
    ssh_key_file = var.ssh_key_file,
    ssh_user = var.ssh_user
  })
  filename = "/home/kunal/upload_to_git_only/AnsibleK/inventory"
}

variable "ssh_key_file" {
  description = "Path to the SSH private key file"
  default     = "/home/kunal/upload_to_git_only/Secrets/devops.pem"
}

variable "ssh_user" {
  description = "SSH user"
  default     = "ubuntu"
}
