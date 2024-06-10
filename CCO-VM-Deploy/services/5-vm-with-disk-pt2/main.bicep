@description('The name of the VM')
param virtualMachineName string

@description('The admin user name of the VM')
param adminUsername string

@description('The admin password of the VM')
@secure()
param adminPassword string

@description('The size in GB of the data disks')
param dataDiskSize int = 1024

@description('The number of data disks to create')
param dataDisksCount int = 2

@description('The Storage type of the data Disks')
@allowed([
  'StandardSSD_LRS'
  'Standard_LRS'
  'Premium_LRS'
])
param diskType string = 'StandardSSD_LRS'

@description('The virtual machine size. Enter a Premium capable VM size if DiskType is entered as Premium_LRS')
@allowed([
  'Standard_D2s_v3'
  'Standard_D2s_v4'
  'Standard_D2s_v5'
  'Standard_D4s_v5'
])
param virtualMachineSize string = 'Standard_D2s_v3'

@description('The Windows version for the VM.')
@allowed([
  '2019-Datacenter'
  '2022-Datacenter'
])
param windowsOSVersion string = '2022-Datacenter'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The address prefix for the virtual network')
param addressPrefix string = '10.0.0.0/16'

@description('The subnet prefix for the virtual network')
param subnetPrefix string = '10.0.0.0/24'

var virtualNetworkName = '${toLower(virtualMachineName)}-vnet'
var subnetName = '${toLower(virtualMachineName)}-subnet'
var OSDiskName = '${toLower(virtualMachineName)}-OSDisk'
var networkInterfaceName = '${toLower(virtualMachineName)}-nic'
var networkSecurityGroupName = '${subnetName}-nsg'

module nsg '../../modules/nsg.bicep' = {
  name: 'nsg'
  params: {
    location: location
    networkSecurityGroupName: networkSecurityGroupName
  }
}

module vnet '../../modules/vnet-new.bicep' = {
  name: 'vnet'
  params: {
    location: location
    virtualNetworkName: virtualNetworkName
    addressPrefix: addressPrefix
    subnetName: subnetName
    subnetPrefix: subnetPrefix
    nsgId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/${nsg.outputs.nsg.resourceId}'
  }
  dependsOn : [
    nsg
  ]
}

module nic '../../modules/nic.bicep' = {
  name: 'nic'
  params: {
    location: location
    networkInterfaceName: networkInterfaceName
    vnetName: virtualNetworkName
    subnetName: subnetName
  }
  dependsOn : [
    vnet
  ]
}

module virtualMachine '../../modules/vm.bicep' = {
  name: 'vm'
  params: {
    location: location
    virtualMachineName: virtualMachineName
    adminUsername: adminUsername
    adminPassword: adminPassword
    diskType: diskType
    dataDiskSize: dataDiskSize
    dataDisksCount: dataDisksCount
    OSDiskName: OSDiskName
    virtualMachineSize: virtualMachineSize
    windowsOSVersion: windowsOSVersion
    nicId: '/subscriptions/${subscription().subscriptionId}/resourceGroups/${resourceGroup().name}/providers/${nic.outputs.nic.resourceId}'
  }
  dependsOn : [
    nic
    vnet
  ]
}



