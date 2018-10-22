#Script is devided in 4 parts, each section should be executed separetely

#Part1
$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$server = Set-AzureRmSqlServer -ResourceGroupName $dbRG -ServerName $dbServer -AssignIdentity



#Part2
$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$KeyVaultName = 'PacktKV';
Set-AzureRmKeyVaultAccessPolicy  -VaultName $KeyVaultName -ObjectId $server.Identity.PrincipalId -PermissionsToKeys get, wrapKey, unwrapKey



#Part3
$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$rgName = 'PacktKeyVault';
$KeyVaultName = 'PacktKV';
$keyEncryptionKeyName = 'MyKey';
$keyEncryptionKeyUrl = (Get-AzureKeyVaultKey -VaultName $KeyVaultName -Name $keyEncryptionKeyName).Key.kid;
Add-AzureRmSqlServerKeyVaultKey -ResourceGroupName $dbRG  -ServerName $dbServer -KeyId $keyEncryptionKeyUrl
Set-AzureRmSqlServerTransparentDataEncryptionProtector -ResourceGroupName $dbRG -ServerName $dbServer -Type AzureKeyVault -KeyId $keyEncryptionKeyUrl
Get-AzureRmSqlServerTransparentDataEncryptionProtector -ResourceGroupName $dbRG -ServerName $dbServer



#Part4
$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$dbName = 'Demo'
Set-AzureRMSqlDatabaseTransparentDataEncryption -ResourceGroupName $dbRG -ServerName $dbServer -DatabaseName $dbName -State "Enabled"
