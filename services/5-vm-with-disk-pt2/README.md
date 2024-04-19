# IT@JH - Create a VM with variable number of empty StandardSSD_LRS Data Disks #

This template allows you to create a Windows Virtual Machine from a specified image while referencing individual modules for storage, network interfaces, network storage groups, and VMs. This template will create a Virtual Network and Network Security Group. It can attach multiple empty StandardSSD data disks. VMs supported are currenlty 

- Standard_D2s_v3
- Standard_D2s_v4 
- Standard_D2s_v5
- Standard_D4s_v5 

Note that you can specify the size and the Storage type (Standard_LRS, StandardSSD_LRS and Premium_LRS) of the empty data disks.

![Bicep Version](https://azurequickstartsservice.blob.core.windows.net/badges/quickstarts/microsoft.compute/vm-with-standardssd-disk/BicepVersion.svg)




[![Visualize](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/visualizebutton.svg?sanitize=true)](http://armviz.io/#/?load=https%3a%2f%2fraw.githubusercontent.com%2fdanfsnet%2fjhu-deployment%2fmaster%2fservices%2f5-vm-with-disk-pt2%2fmain.json)


[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3a%2f%2fraw.githubusercontent.com%2fdanfsnet%2fjhu-deployment%2fmaster%2fservices%2f5-vm-with-disk-pt2%2fmain.json/uiFormDefinitionUri/https%3a%2f%2fraw.githubusercontent.com%2fdanfsnet%2fjhu-deployment%2fmaster%2fservices%2f5-vm-with-disk-pt2%2fcreateUiDefinition.json)

[![Deploy To Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#blade/Microsoft_Azure_CreateUIDef/CustomDeploymentBlade/uri/https%3a%2f%2fraw.githubusercontent.com%2fdanfsnet%2fjhu-deployment%2fmaster%2fservices%2f5-vm-with-disk-pt2%2fmain.json/uiFormDefinitionUri/https%3a%2f%2fraw.githubusercontent.com%2fdanfsnet%2fjhu-deployment%2fmaster%2fservices%2f5-vm-with-disk-pt2%2fcreateUiDefinition.json)