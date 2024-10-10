# Azure Quick Review
Set-Location -Path 'C:\repos\aztools\Demos\azqr\'

# Install Azure Quick Review
winget install azqr

# Log in to Azure (Can also use ENV variables or Managed Identity)
az login

# Scan a resource group in a specific subscription
azqr scan -s "<subscription id>"

# Alternative commands
#Scan all resource groups in all subscription:
#./azqr scan
#Scan all resource groups in a specific subscription:
#./azqr scan -s <subscription_id> -g <resource group>