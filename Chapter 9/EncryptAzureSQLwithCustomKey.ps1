$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$server = Set-AzureRmSqlServer -ResourceGroupName $dbRG -ServerName $dbServer -AssignIdentity


$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$KeyVaultName = 'PacktKV';
Set-AzureRmKeyVaultAccessPolicy  -VaultName $KeyVaultName -ObjectId $server.Identity.PrincipalId -PermissionsToKeys get, wrapKey, unwrapKey



$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$rgName = 'PacktKeyVault';
$KeyVaultName = 'PacktKV';
$keyEncryptionKeyName = 'MyKey';
$keyEncryptionKeyUrl = (Get-AzureKeyVaultKey -VaultName $KeyVaultName -Name $keyEncryptionKeyName).Key.kid;


<# Add the key from Key Vault to the server #>
Add-AzureRmSqlServerKeyVaultKey -ResourceGroupName $dbRG  -ServerName $dbServer -KeyId $keyEncryptionKeyUrl

<# Set the key as the TDE protector for all resources under the server #>
Set-AzureRmSqlServerTransparentDataEncryptionProtector -ResourceGroupName $dbRG -ServerName $dbServer -Type AzureKeyVault -KeyId $keyEncryptionKeyUrl

<# To confirm that the TDE protector was configured as intended: #>
Get-AzureRmSqlServerTransparentDataEncryptionProtector -ResourceGroupName $dbRG -ServerName $dbServer

$dbRG = 'PacktPaaSDB';
$dbServer = 'packt';
$dbName = 'Demo'
Set-AzureRMSqlDatabaseTransparentDataEncryption -ResourceGroupName $dbRG -ServerName $dbServer -DatabaseName $dbName -State "Enabled"