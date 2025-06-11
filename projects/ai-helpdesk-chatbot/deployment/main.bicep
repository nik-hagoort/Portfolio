param sites_function_app_name string = 'my-function-app'
param serverfarms_app_service_plan_externalid string = '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group/providers/Microsoft.Web/serverfarms/my-app-service-plan'

resource sites_function_app_name_resource 'Microsoft.Web/sites@2024-04-01' = {
  name: sites_function_app_name
  location: 'South Central US'
  tags: {
    'hidden-link: /app-insights-resource-id': '/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/my-resource-group/providers/microsoft.insights/components/my-function-app'
    'hidden-link: /app-insights-instrumentation-key': '00000000-0000-0000-0000-000000000000'
    'hidden-link: /app-insights-conn-string': 'InstrumentationKey=00000000-0000-0000-0000-000000000000;IngestionEndpoint=https://region.in.applicationinsights.azure.com/;LiveEndpoint=https://region.livediagnostics.monitor.azure.com/;ApplicationId=00000000-0000-0000-0000-000000000000'
  }
  kind: 'functionapp'
  properties: {
    enabled: true
    hostNameSslStates: [      {
        name: '${sites_function_app_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_function_app_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_app_service_plan_externalid
    reserved: false
    isXenon: false
    hyperV: false
    dnsConfiguration: {}
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 200
      minimumElasticInstanceCount: 0
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    ipMode: 'IPv4'
    vnetBackupRestoreEnabled: false
    customDomainVerificationId: 'EXAMPLE1234567890ABCDEF1234567890ABCDEF1234567890ABCDEF1234567890'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: true
    endToEndEncryptionEnabled: false
    redundancyMode: 'None'
    publicNetworkAccess: 'Enabled'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_function_app_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_function_app_name_resource
  name: 'ftp'
  properties: {
    allow: false
  }
}

resource sites_function_app_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2024-04-01' = {
  parent: sites_function_app_name_resource
  name: 'scm'
  properties: {
    allow: false
  }
}

resource sites_function_app_name_web 'Microsoft.Web/sites/config@2024-04-01' = {
  parent: sites_function_app_name_resource
  name: 'web'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v8.0'
    powerShellVersion: '7.4'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: 'REDACTED'
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    publicNetworkAccess: 'Enabled'
    cors: {
      allowedOrigins: [
        'https://portal.azure.com'
      ]
      supportCredentials: false
    }
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 200
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 0
    azureStorageAccounts: {}
  }
}

resource sites_function_app_name_HelpdeskChat 'Microsoft.Web/sites/functions@2024-04-01' = {
  parent: sites_function_app_name_resource
  name: 'HelpdeskChat'
  properties: {
    script_root_path_href: 'https://my-function-app.azurewebsites.net/admin/vfs/site/wwwroot/HelpdeskChat/'
    script_href: 'https://my-function-app.azurewebsites.net/admin/vfs/site/wwwroot/HelpdeskChat/run.ps1'
    config_href: 'https://my-function-app.azurewebsites.net/admin/vfs/site/wwwroot/HelpdeskChat/function.json'
    test_data_href: 'https://my-function-app.azurewebsites.net/admin/vfs/data/Functions/sampledata/HelpdeskChat.dat'
    href: 'https://my-function-app.azurewebsites.net/admin/functions/HelpdeskChat'
    config: {
      bindings: [
        {
          authLevel: 'function'
          type: 'httpTrigger'
          direction: 'in'
          name: 'Request'
          methods: [
            'get'
            'post'
          ]
        }
        {
          type: 'http'
          direction: 'out'
          name: 'Response'
        }
      ]
    }
    invoke_url_template: 'https://my-function-app.azurewebsites.net/api/helpdeskchat'
    language: 'powershell'
    isDisabled: false
  }
}

resource sites_function_app_name_hostname_binding 'Microsoft.Web/sites/hostNameBindings@2024-04-01' = {
  parent: sites_function_app_name_resource
  name: '${sites_function_app_name}.azurewebsites.net'
  properties: {
    siteName: 'my-function-app'
    hostNameType: 'Verified'
  }
}
