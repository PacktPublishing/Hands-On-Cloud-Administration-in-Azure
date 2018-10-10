$webappname='packt-demo-cli-webapp-01'
$ResourceGroupName ='packt-demo-cli'
az group create --location westeurope --name $ResourceGroupName
az appservice plan create --name $webappname --resource-group $ResourceGroupName --sku Free
az webapp create --name $webappname --resource-group $ResourceGroupName --plan $webappname