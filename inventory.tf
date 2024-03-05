# Define local variables
locals {
  ansible_ssh_args = "-o StrictHostKeyChecking=no"
}

# Generate Ansible inventory file
resource "local_file" "ansible_inventory" {
  filename = var.ansible_host_path
  content  = <<-EOT
    [lap]
    %{ for ip in aws_instance.main.*.public_ip ~} 
    ${ip} ansible_host=${ip} ansible_user=${var.ansible_user} ansible_ssh_private_key_file=${var.ansible_ssh_private_key_file} ansible_ssh_common_args='${local.ansible_ssh_args}' ansible_ssh_connection=ssh 
    %{ endfor ~}
  EOT
  depends_on = [aws_instance.main]
}

# Generate environment variable file for app connection
resource "local_file" "env_connect" {
  filename = var.fe_to_api_path
  content  = <<-EOT
    %{ for ip in aws_instance.main.*.public_ip ~} 
    VITE_API_SERVER=http://${ip}:13000
    %{ endfor ~}
  EOT
  depends_on = [aws_instance.main, local_file.ansible_inventory]
}

# Trigger Ansible playbook execution command 01
resource "null_resource" "playbook_install_docker" {
  triggers = {
    key = uuid()
  }
  provisioner "local-exec" {
    command = "ansible-playbook ${var.ansible_command_01} -i ${var.ansible_host_path}"
  }
  depends_on = [aws_instance.main, local_file.ansible_inventory, local_file.env_connect]
}

# Trigger Ansible playbook execution command 02
resource "null_resource" "playbook_run_App" {
  triggers = {
    key = uuid()
  }
  provisioner "local-exec" {
    command = "tar -czvf ansible/App.tar.gz -C ansible App && ansible-playbook ${var.ansible_command_02} -i ${var.ansible_host_path} "
  }
  depends_on = [aws_instance.main, local_file.ansible_inventory, null_resource.playbook_install_docker, local_file.env_connect]
}
