# Azure Visualizer (AzViz)
Set-Location -Path 'C:\repos\aztools\Demos\Demos\AzViz\'

# Install GraphViz Pre-req
## Using windows package manager
winget install graphviz
## Alternatively chocolatey packages Graphviz for Windows
#choco install graphviz

# Install from Powershell Gallery
Install-Module -Name AzViz -Scope CurrentUser -Repository PSGallery -Force

# Import the module and Connect to Azure
Import-Module -Name AzViz
Connect-AzAccount -Tenant "8940c948-d605-4e9a-b426-91153d1275f9" -Subscription "847cb8f3-802b-42ab-aa9b-fe9d17d25580"

# Export a Resource Group
Export-AzViz -ResourceGroup 'rg-australiaeast-demohub', 'rg-australiaeast-demospoke' -Theme light -CategoryDepth 2 -OutputFormat png -Show