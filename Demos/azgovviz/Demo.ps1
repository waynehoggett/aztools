# Azure Governance Visualizer (AzGovViz)
Set-Location -Path 'C:\repos\aztools\Demos\azgovviz'

# Clone the repository
Remove-Item -Path '.\Azure-MG-Sub-Governance-Reporting' -Recurse -Force
git clone "https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting.git"
Set-Location -Path '.\Azure-MG-Sub-Governance-Reporting'

# Authenticate to Azure
# You need an account with Reader at the target management group, can be a MI/SP
Connect-AzAccount -Tenant '<tenant id>'

# Run AzGovViz
New-Item -Path 'C:\repos\aztools\Demos\azgovviz\' -Name 'Output' -ItemType Directory
.\pwsh\AzGovVizParallel.ps1 -ManagementGroupId '<management group id>' -OutputPath 'C:\repos\aztools\Demos\azgovviz\Output'