echo "Creating Rocky VM "
cd /home/nutanix/terraform_blog/intro
terraform init
terraform plan -out "main.out"
terraform apply -parallelism=25 "/home/nutanix/terraform_blog/intro/main.out"
echo "Creating Windows VM 2"
cd /home/nutanix/terraform_blog/intro2
terraform init
terraform plan -out "main.out"
terraform apply -parallelism=25 "/home/nutanix/terraform_blog/intro2/main.out"
