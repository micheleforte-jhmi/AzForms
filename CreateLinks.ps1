# Prompt the user to enter the ARM template JSON link
$link_to_arm_json = Read-Host -Prompt "Please enter the link ARM template JSON file"

# Prompt the user to enter the CreateUiDefinition JSON link
$link_to_createUiDefinition_json = Read-Host -Prompt "Please enter the link to the CreateUiDefinition JSON file"

# URL encode the input paths
Add-Type -AssemblyName System.Web
$link_to_arm_json = [System.Web.HttpUtility]::UrlEncode($link_to_arm_json)
$link_to_createUiDefinition_json = [System.Web.HttpUtility]::UrlEncode($link_to_createUiDefinition_json)

# Construct the URL
$url = "[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/$link_to_arm_json/uiFormDefinitionUri/$link_to_createUiDefinition_json)"
$url2 = "https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/$link_to_arm_json/uiFormDefinitionUri/$link_to_createUiDefinition_json"
# Output the final URL
Write-Host "Deployment Link:" -ForegroundColor Cyan
Write-Host $url2 -ForegroundColor Cyan
Write-Host "Deployment button link:"
Write-Host $urlS

