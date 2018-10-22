$ResourceGroupName = "packt-demo-ps-multiple"
$webappname="packt-demo-ps-webapp"
$location="West Europe"
$NumberOfWebApps= 4

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $locationNew-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName $ResourceGroupName -Tier Standard

$i=1

Do

{

New-AzureRmWebApp -Name $webappname'-0'$i -Location $location -AppServicePlan $webappname -ResourceGroupName $ResourceGroupName

} While (($i=$I+1) -le $NumberOfWebApps)