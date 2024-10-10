# Azure Export for Terraform (aztfexport)
Remove-Item 'C:\repos\aztools\Demos\aztfexport\output' -Recurse -Force -ErrorAction SilentlyContinue
New-Item -Path 'C:\repos\aztools\Demos\aztfexport\' -Name 'output' -ItemType Directory
Set-Location -Path 'C:\repos\aztools\Demos\aztfexport\output'

# Install AZTFExport
winget install aztfexport

# Update Env/PATH if required

# Export a single resource group
az login --tenant <tenant id>
az account set --name VSE
aztfexport resource-group rg-australiaeast-demohub

# Alternatives Commands
## Export a single resource
### aztfexport resource <resourceid>
## Export using a query
### aztfexport query <query>