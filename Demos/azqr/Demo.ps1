# Azure Quick Review

# Install Azure Quick Review
winget install azqr


# Scan a resource group in a specific subscription
./azqr scan -s "847cb8f3-802b-42ab-aa9b-fe9d17d25580" -g "rg-australiaeast-demoresources"

# Alternative commands
#Scan all resource groups in all subscription:
#./azqr scan
#Scan all resource groups in a specific subscription:
#./azqr scan -s <subscription_id>