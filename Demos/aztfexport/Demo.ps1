# Azure Export for Terraform (aztfexport)
Remove-Item 'C:\repos\aztools\Demos\aztfexport\output' -Recurse -Force 
New-Item -Name 'C:\repos\aztools\Demos\aztfexport\output' -ItemType Directory
Set-Location -Path 'C:\repos\aztools\Demos\aztfexport\output'

# Install AZTFExport
winget install aztfexport

# Restart your shell or refreshenv (from Chocolatey)

# Export a single resource group
az login --tenant 8940c948-d605-4e9a-b426-91153d1275f9
az account set --name VSE
aztfexport resource-group rg-australiaeast-demohub

# Alternatives Commands
## Export a single resource
### aztfexport resource <resourceid>
## Export using a query
### aztfexport query <query>