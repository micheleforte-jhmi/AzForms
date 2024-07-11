param(
    [Parameter(Mandatory=$true)]
    [string]$link_to_arm_json,

    [Parameter(Mandatory=$true)]
    [string]$link_to_createUiDefinition_json
)

Add-Type -AssemblyName System.Web

$mainjson = "https://raw.githubusercontent.com/micheleforte-jhmi/AzForms/master/services/13-vm-with-image/vm-image.json"
$createUijson = "https://raw.githubusercontent.com/micheleforte-jhmi/AzForms/master/services/13-vm-with-image/CreateUiDefinition.json"

# URL encode the input paths
$link_to_arm_json = [System.Web.HttpUtility]::UrlEncode($link_to_arm_json)
$link_to_createUiDefinition_json = [System.Web.HttpUtility]::UrlEncode($link_to_createUiDefinition_json)



# Construct the URL
$url = "[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/$link_to_arm_json/uiFormDefinitionUri/$link_to_createUiDefinition_json)"
Write-Host $url

# $visualizeUrl = "[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=$link_to_arm_json)"
# Write-Host $visualizeUrl


# powershell -File generate-buttons.ps1 -link_to_arm_json $mainjson -link_to_createUiDefinition_json $createUijson

# https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f7-vm-with-disk-pt4%2fmain.json/uiFormDefinitionUri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f7-vm-with-disk-pt4%2fcreateUiDefinition.json

# https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f9-vm%2fmain.json/uiFormDefinitionUri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f9-vm%2fCreateUiDefinition.json

# https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f10-vm%2fmain.json/uiFormDefinitionUri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f10-vm%2fCreateUiDefinition.json

# https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f11-storage%2fstorage.json/uiFormDefinitionUri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f11-storage%2fCreateUiDefinition.json

https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f13-vm-with-image%2fvm-image.json/uiFormDefinitionUri/https%3a%2f%2fraw.githubusercontent.com%2fmicheleforte-jhmi%2fAzForms%2fmaster%2fservices%2f13-vm-with-image%2fCreateUiDefinition.json