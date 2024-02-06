***App with Storage Example***

This service will deploy an Azure App Service along with a storage account.

The expected parameters for this deployment are:

| Name | Type | Description |
| --- | --- | --- |
| environmentType | string | The environment type (e.g., dev, test, prod) |
| location | string | The location for the resources |
| prefix | string | The prefix for the resources |
| storageAccountName | string | The name of the storage account |

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

// removed, now in module 
//var appServicePlanSkuName = (environmentType == 'prod') ? 'P2v3' : 'F1'

param location string = resourceGroup().location
param prefix string= 'danfsnet'
param storageAccountName string

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3A%2F%2Fgithub.com%2Fdanfsnet%2Fjhu-deployment%2Fblob%2Fmaster%2Fservices%2F1-app-with-storage%2Fazure-deploy.json/uiFormDefinitionUri/https%3A%2F%2Fgithub.com%2Fdanfsnet%2Fjhu-deployment%2Fblob%2Fmaster%2Fservices%2F1-app-with-storage%2FcreateUiDefinition.json)