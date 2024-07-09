@description('The name of the VM')
param virtualMachineName string

@description('The location of the VM in Azure')
@allowed([
  'JH-TRAINING-TEST-RG'
  'JH-TRAINING-PROD-RG'
])
param location string = 'JH-TRAINING-PROD-RG'

@description('The virtual machine size. Enter a Premium capable VM size if DiskType is entered as Premium_LRS')
@allowed([
  'Standard_D2s_v3'
  'Standard_D2s_v4'
  'Standard_D2s_v5'
  'Standard_D4s_v5'
])
param virtualMachineSize string

@description('The admin user name of the VM')
param adminUsername string

@description('The admin password of the VM')
@secure()
param adminPassword string

@description('The Storage type of the data Disks')
@allowed([
  'StandardSSD_LRS'
  'Standard_LRS'
  'Premium_LRS'
])
param diskType string

@description('The Windows version for the VM.')
@allowed([
  '2019-Datacenter'
  '2022-Datacenter'
])
param windowsOSVersion string

@description('The number of data disks to create')
@maxValue(2)
param dataDisksCount int

@description('The size in GB of the data disks')
@maxValue(5024)
param dataDiskSize int

param OSDiskName string

// @description('The id of the network interface/nic')
// param nicId string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: virtualMachineName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    osProfile: {
      computerName: virtualMachineName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      osDisk: {
        osType: 'Windows'
        name: OSDiskName
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: diskType
        }
        diskSizeGB: 128
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: windowsOSVersion
        version: 'latest'
      }
      dataDisks: [for j in range(0, dataDisksCount): {
        name: '${virtualMachineName}-DataDisk${j}'
        diskSizeGB: dataDiskSize
        lun: j
        createOption: 'Empty'
        managedDisk: {
          storageAccountType: diskType
        }
      }]
    }
    // networkProfile: {
    //   networkInterfaces: [
    //     {
    //       id: nicId
    //     }
    //   ]
    // }
  }
}
