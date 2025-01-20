echo "Creating Rocky VM "
cd /home/nutanix/terraform_blog/rocky_batch
terraform init
terraform plan -out "main.out"
terraform apply -parallelism=25 "/home/nutanix/terraform_blog/rocky_batch/main.out"
echo "Creating Windows VM 2"
cd /home/nutanix/terraform_blog/windows_batch
terraform init
terraform plan -out "main.out"
terraform apply -parallelism=25 "/home/nutanix/terraform_blog/windows_batch/main.out"
