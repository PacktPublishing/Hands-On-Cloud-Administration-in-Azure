$ResourceGroupName = "packt-demo"
$location = "westeurope"
$vmName = "packtdemoVM"
$NumberOfServers= 2

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $location

$i=1

Do

{

New-AzureRmVm -ResourceGroupName $ResourceGroupName -Name $vmName"-0"$i -Location $location -VirtualNetworkName $vmName"-Vnet" -SubnetName $vmName"-subnet" -SecurityGroupName $vmName"-nsg" -PublicIpAddressName $vmName"-IP-"$i -OpenPorts 80,443,3389

} While (($i=$I+1) -le $NumberOfServers)