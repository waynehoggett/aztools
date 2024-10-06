var location = 'eastus'
var vmUsername  = 'AdminUser'
var vmPassword  = substring(resourceGroup().name, 0, 11 )

resource vneteastushub 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'vnet-eastus-hub'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

resource vneteastusspoke1 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'vnet-eastus-spoke1'
  location: location
  dependsOn: [
    vneteastushub // This is not required, but helps with lesson
  ]
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.1.0.0/24'
        }
      }
    ]
  }
}

resource peervneteastushubtovneteastusspoke1 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  parent: vneteastushub
  name: 'peer-vnet-eastus-hub-to-vnet-eastus-spoke1'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vneteastusspoke1.id
    }
  }
}

resource peervneteastusspoke1tovneteastushub 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
  parent: vneteastusspoke1
  name: 'peer-vnet-eastus-spoke1-to-vnet-eastus-hub'
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: vneteastushub.id
    }
  }
}

resource vnetremotenetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'vnet-eastus-remotenetwork'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.2.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.2.255.0/27'
        }
      }
      {
        name: 'default'
        properties: {
          addressPrefix: '10.2.1.0/24'
        }
      }
    ]
  }
}

resource vpngremotenetwork 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: 'vpng-remotenetwork'
  location: location
  dependsOn: [
    vnetremotenetwork
    publicIPAddressvpngremotenewtork
  ]
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1-vpngremotenetwork'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vnetremotenetwork.properties.subnets[0].id
          }
          publicIPAddress: {
            id: publicIPAddressvpngremotenewtork.id
          }
        }
      }
    ]
    sku: {
      name: 'VpnGw2'
      tier: 'VpnGw2'
    }
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
  }
}

resource publicIPAddressvpngremotenewtork 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: 'pip-vpngremotenetwork'
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource nicvnetclient 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'nic-vnetclient'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1-nic1-vnetclient'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vneteastusspoke1.properties.subnets[0].id
          }
        }
      }
    ]
  }
}

resource vmwvnetclient 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'vmw-vnetclient'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    osProfile: {
      computerName: 'vnetclient'
      adminUsername: vmUsername
      adminPassword: vmPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        name: 'osdisk-vmw-vnetclient'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicvnetclient.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
  }
}

resource pipnicremoteclient 'Microsoft.Network/publicIPAddresses@2023-09-01' = {
  name: 'pip-nicremoteclient'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource nicremoteclient 'Microsoft.Network/networkInterfaces@2020-11-01' = {
  name: 'nic-remoteclient'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1-nic1-remoteclient'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: vnetremotenetwork.properties.subnets[1].id
          }
          publicIPAddress: {
            id: pipnicremoteclient.id
          }
        }
      }
    ]
  }
}

resource vmwremoteclient 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'vmw-remoteclient'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    osProfile: {
      computerName: 'remoteclient'
      adminUsername: vmUsername
      adminPassword: vmPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition'
        version: 'latest'
      }
      osDisk: {
        name: 'osdisk-vmw-remoteclient'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nicremoteclient.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
      }
    }
  }
}

output vmUsername string = vmUsername
output vmpassword string = vmPassword
