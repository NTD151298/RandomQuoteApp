# ssh to vm box ansible1
ssh -p 2001 duongtn1512@127.0.0.1 

# ansible install
sudo apt update 
sudo apt install software-properties-common 
sudo add-apt-repository --yes --update ppa:ansible/ansible 
sudo apt -y install ansible
ansible --version
cd /etc/ansible

# install terraform
sudo apt update && sudo apt -y upgrade 
sudo apt install curl software-properties-common 

wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg 

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list 

sudo apt update && sudo apt install terraform 
terraform version 

# hosts file store addr of taraget machine we want to connect
[localhost] 
127.0.0.1 
[lap_app]
3.84.93.131 ansible_ssh_user=ec2-user ansible_ssh_private_key_file=Key_AWS_1.pem

# connect to taraget machine
ssh -i key/key5.pem ubuntu@3.84.93.131

# ping to check connection, taraget machine must turn on sg allow to get ping
wsl ansible lap_app -m ping 

# mount file from vmbox machine to host machine
winscp bro !

# Aws cli
aws sts get-caller-identity
aws configure list
aws configure 

# Teraform
terraform init
terraform apply --auto-approve
terraform destroy --auto-approve
terraform plan
terraform validate

# Command pass time 5h in vm box ubuntu
cat ansible/inventory/lap
ssh -i key/key5.pem ubuntu@54.169.127.7
terraform apply --auto-approve
terraform destroy --auto-approve
rm ansible/playbook/install-jenkins-container.yml
nano ansible/playbook/install-jenkins-container.yml
history

# Git config user
git config --global user.name "NTD1512"
git config --global user.email "duongtn1512@gmail.com"

# Fire wall ubuntu
sudo apt-get install ufw
sudo ufw allow ssh
sudp ufw allow https
sudo ufw allow http
sudo reboot

# Nginx systemctl
sudo systemctl restart nginx
sudo systemctl status nginx
sudo ss -tuln 

