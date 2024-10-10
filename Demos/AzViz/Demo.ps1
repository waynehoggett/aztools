# Azure Visualizer (AzViz)
Set-Location -Path 'C:\repos\aztools\Demos\AzViz\'

# Install GraphViz Pre-req
## Using windows package manager
winget install graphviz
## Alternatively chocolatey packages Graphviz for Windows
#choco install graphviz

# Install from Powershell Gallery
Install-Module -Name AzViz -Scope CurrentUser -Repository PSGallery -Force

# Import the module and Connect to Azure
Import-Module -Name AzViz
Connect-AzAccount -Tenant "<tenant id>" -Subscription "<subscription id>"

# Export a Resource Group
Export-AzViz -ResourceGroup '<resource group name 1>', '<optional resource group name 2>' -Theme light -CategoryDepth 2 -OutputFormat png -Show