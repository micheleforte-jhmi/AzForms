param adminUsername string = 'cloudadm'
param prefix string
param vmName string = '${prefix}-vm-01'
param computerName string = '${prefix}-profile'

// Generate a unique disk name to avoid collisions
param diskName string = '${prefix}-disk-${uniqueString(resourceGroup().id)}'

@allowed([
  'eastus'
  'eastus2'
])
param location string
param networkInterfaceExternalId string = '/subscriptions/b0527a49-e536-4464-9ee4-e4cc91be89d2/resourceGroups/danfs.net-bicep-vm/providers/Microsoft.Network/networkInterfaces/danfsnet-bicep-vm-01829_z1'

@allowed([
  'Standard_D2s_v5'
  'Standard_D4s_v5'
])
param vmSize string 

@allowed([
  '2022-datacenter-azure-edition'
  '2019-datacenter'
])
param vmSku string 

@allowed([
  'Premium_LRS'
])
param storageSku string 

module storage '../../modules/disk.bicep' = {
  name: 'storage'
  params: {
    location: location
    disks_name: diskName
    sku_name: storageSku
  }
}

resource virtualMachines_danfsnet_bicep_vm_01_name_resource 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location
  zones: [
    '1'
  ]
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    additionalCapabilities: {
      hibernationEnabled: false
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: vmSku
        version: 'latest'
      }
      osDisk: {
        osType: 'Windows'
        name: '${vmName}_OsDisk_1_2bcd0c4fad8c44488eb1a401e19df584'
        createOption: 'FromImage'
        caching: 'ReadWrite'
        managedDisk: {
          storageAccountType: 'Premium_LRS'
          id: storage.outputs.subnetIds[0].id
        }
        deleteOption: 'Delete'
        diskSizeGB: 128
      }
      diskControllerType: 'SCSI'
    }
    osProfile: {
      computerName: computerName
      adminUsername: adminUsername
      windowsConfiguration: {
        provisionVMAgent: true
        enableAutomaticUpdates: true
        patchSettings: {
          patchMode: 'AutomaticByOS'
          assessmentMode: 'ImageDefault'
          enableHotpatching: false
        }
        enableVMAgentPlatformUpdates: false
      }
      secrets: []
      allowExtensionOperations: true
      requireGuestProvisionSignal: true
    }
    securityProfile: {
      uefiSettings: {
        secureBootEnabled: true
        vTpmEnabled: true
      }
      securityType: 'TrustedLaunch'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterfaceExternalId
          properties: {
            deleteOption: 'Detach'
          }
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
      }
    }
    licenseType: 'Windows_Server'
  }
}
