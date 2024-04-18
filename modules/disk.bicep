// Define the parameters for the module
param disks_name string
param location string
param sku_name string

param zones array = ['1']
param osType string = 'Windows'
param hyperVGeneration string = 'V2'
param supportsHibernation bool = true
param diskControllerTypes string = 'SCSI, NVMe'
param acceleratedNetwork bool = true
param architecture string = 'x64'
param createOption string = 'FromImage'
param imageReference_id string
param diskSizeGB int = 128 // minimum required
param diskIOPSReadWrite int = 500
param diskMBpsReadWrite int = 100
param encryption_type string = 'EncryptionAtRestWithPlatformKey'
param networkAccessPolicy string = 'AllowAll'
param securityType string = 'TrustedLaunch'
param publicNetworkAccess string = 'Disabled'

// Define the resource using the parameters
resource disks 'Microsoft.Compute/disks@2023-01-02' = {
  name: disks_name
  location: location
  sku: {
    name: sku_name
  }
  zones: zones
  properties: {
    osType: osType
    hyperVGeneration: hyperVGeneration
    supportsHibernation: supportsHibernation
    supportedCapabilities: {
      diskControllerTypes: diskControllerTypes
      acceleratedNetwork: acceleratedNetwork
      architecture: architecture
    }
    creationData: {
      createOption: createOption
      imageReference: {
        id: imageReference_id
      }
    }
    diskSizeGB: diskSizeGB
    diskIOPSReadWrite: diskIOPSReadWrite
    diskMBpsReadWrite: diskMBpsReadWrite
    encryption: {
      type: encryption_type
    }
    networkAccessPolicy: networkAccessPolicy
    securityProfile: {
      securityType: securityType
    }
    publicNetworkAccess: publicNetworkAccess
  }
}

output disks object = disks
