Lab 1 instructions:

1. Install Terraform:
  follow this link to install terraform on your workstation : https://learn.hashicorp.com/terraform/getting-started/install.html
  
2. Create in your Azure subscription service principal :
  follow this link to create service principal in your subscription (this service principal later on will grant terraform to make changes     on your Azure subscription on your behalf: 
  https://docs.microsoft.com/en-us/powershell/azure/create-azure-service-principal-azureps?view=azps-2.4.0#create-a-service-principal
  
3. Add the client_id, client_secret, subscription_id, tenant_id you got from the output of the previous stage to your environment              variables:
    ARM_CLIENT_ID 
    ARM_CLIENT_SECRET
    ARM_SUBSCRIPTION_ID
    ARM_TENANT_ID
    
4. Clone erezs80/Terraform-Demo :
  git clone https://github.com/erezs80/Terraform-Demo.git
  
5. Go to the lab1 folder : 
  cd Terraform-Demo\Labs\lab1

6. Initial terraform in the folder:
  terraform init

7. Now try to run terraform plan command to see what terraform going to change :
  terraform plan
  
8. After the plan command, you are ready to apply the changes!!! run terraform apply command :
  terraform apply
  enter "yes" to continue

9. Login to Azure portal and check the terraform created resource group called terrademo-RG with vnet and vm inside him

10. Now you ready to make a change to your deployment :
  a. open the terraform.tfvars file and change the number of "vm_count" to 2 and save the file
  b. run terraform plan
  c. run terraform apply
  d. check in the azure portal that only 1 vm had been added to your deployment

11. Clean the resources we created during the lab :
  terraform destroy
  enter "yes" to continue
