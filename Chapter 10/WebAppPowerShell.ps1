$ResourceGroupName = "packt-demo-ps"
$webappname="packt-demo-ps-webapp-01"
$location="West Europe"
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $location
New-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName $ResourceGroupName -Tier Free
New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName $ResourceGroupName