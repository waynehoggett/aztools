# Maester
Set-Location 'C:\repos\aztools\Demos\Maester'

# Install the Maester PowerShell module, Pester, and the out of the box tests.
Install-Module Pester -SkipPublisherCheck -Force -Scope CurrentUser
Install-Module Maester -Scope CurrentUser -Force

New-Item -Path 'maester-tests' -ItemType Directory -ErrorAction SilentlyContinue
Set-Location -Path 'maester-tests'
Install-MaesterTests

# Sign into your tenant and run the tests
Connect-Maester
Invoke-Maester