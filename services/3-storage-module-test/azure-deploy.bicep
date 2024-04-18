param location string = 'eastus'
// diskName add new guid
param diskName string = 'danfsnet-disk-test${uniqueString(resourceGroup().id)}'
param storageSku string = 'Standard_LRS'
param imageReferenceId string = '/Subscriptions/b0527a49-e536-4464-9ee4-e4cc91be89d2/Providers/Microsoft.Compute/Locations/eastus2/Publishers/MicrosoftWindowsServer/ArtifactTypes/VMImage/Offers/WindowsServer/Skus/2022-datacenter-azure-edition/Versions/20348.2340.240303'

module storage '../../modules/disk.bicep' = {
  name: 'storage'
  params: {
    location: location
    disks_name: diskName
    sku_name: storageSku
    imageReference_id: imageReferenceId
  }
}
