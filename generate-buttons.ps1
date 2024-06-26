param(
    [Parameter(Mandatory=$true)]
    [string]$link_to_arm_json,

    [Parameter(Mandatory=$true)]
    [string]$link_to_createUiDefinition_json
)

Add-Type -AssemblyName System.Web

$mainjson = "https://raw.githubusercontent.com/micheleforte-jhmi/AzForms/master/services/6-vm-with-disk-pt3/newmain.json"
$createUijson = "https://raw.githubusercontent.com/micheleforte-jhmi/AzForms/master/services/6-vm-with-disk-pt3/createUiDefinition.json"

# URL encode the input paths
$link_to_arm_json = [System.Web.HttpUtility]::UrlEncode($link_to_arm_json)
$link_to_createUiDefinition_json = [System.Web.HttpUtility]::UrlEncode($link_to_createUiDefinition_json)

# Construct the URL
$url = "[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/$link_to_arm_json/uiFormDefinitionUri/$link_to_createUiDefinition_json)"
Write-Host $url

$visualizeUrl = "[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=$link_to_arm_json)"
Write-Host $visualizeUrl


#powershell -File generate-buttons.ps1 -link_to_arm_json $mainjson -link_to_createUiDefinition_json $createUijson