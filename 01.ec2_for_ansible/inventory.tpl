[ec2_instances]
%{ for ip in public_ips ~}
${ip} ansible_ssh_private_key_file=${ssh_key_file}  ansible_user=${ssh_user}
%{ endfor ~}