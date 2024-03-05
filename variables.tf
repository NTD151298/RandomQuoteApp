
variable "ansible_user" {
  type        = string
  description = "Ansible user used to connect to the instance"
  default     = "ubuntu"
}
variable "ansible_ssh_private_key_file" {
  type        = string
  sensitive   = true
  description = "ssh key file to use for ansible_user"
  default     = "./key/key5.pem"
}
variable "ansible_ssh_public_key_file" {
  type        = string
  sensitive   = true
  description = "ssh public key in server authorized_keys"
  default     = "./key/key5.pub"
}
variable "ansible_host_path" {
  type        = string
  description = "path to ansible inventory host"
  default     = "./ansible/inventory/lap"
}
# Control flow
variable "ansible_ssh_args" {
  type    = string
  default = "-o ControlMaster=auto -o ControlPersist=60s -o Compression=yes"
}
# Install docker
variable "ansible_command_01" {
  default     = "./ansible/playbook/install-docker.yml"
  description = "Command for container lab hosts"
}
# Run app
variable "ansible_command_02" {
  default     = "./ansible/playbook/run-app.yml"
  description = "Command for container lab hosts"
}
# Change fe to api env file
variable "fe_to_api_path" {
  default = "./ansible/App/FE/.env"
  description = "path to env file that connect fe with api app"
}
# Using ansible to copy file
variable "ansible_copy_path" {
  default = "./ansible/playbook/run-app.yml"
  description = "write a playbook file for ansible to copy"
}
