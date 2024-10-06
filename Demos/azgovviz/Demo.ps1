# Azure Governance Visualizer (AzGovViz) 
# Takes quite a while to run, so here is one I prepared earlier
Invoke-Item -Path "C:\repos\aztools\Demos\azgovviz\Output\AzGovViz_6.5.4_20241006_113529_8940c948-d605-4e9a-b426-91153d1275f9.html"

# This is how I ran it:
# Azure Governance Visualizer (AzGovViz)
Set-Location -Path 'C:\repos\aztools\Demos\azgovviz'

# Clone the repository
Remove-Item -Path '.\Azure-MG-Sub-Governance-Reporting' -Recurse -Force
git clone "https://github.com/JulianHayward/Azure-MG-Sub-Governance-Reporting.git"
Set-Location -Path '.\Azure-MG-Sub-Governance-Reporting'

# Authenticate to Azure
# You need an account with Reader at the target management group, can be a MI/SP
Connect-AzAccount -Tenant '8940c948-d605-4e9a-b426-91153d1275f9'

# Run AzGovViz
New-Item -Path 'C:\repos\aztools\Demos\azgovviz\' -Name 'Output' -ItemType Directory
.\pwsh\AzGovVizParallel.ps1 -ManagementGroupId '8940c948-d605-4e9a-b426-91153d1275f9' -OutputPath 'C:\repos\aztools\Demos\azgovviz\Output'