<div class="platform-selector" id="troubleshooting-clusters" data-module="app-tabs">
  <ul class="app-tabs" role="tablist">
    <li class="app-tabs__item js-tabs__item js-tabs__item--open" role="presentation">
      <a href="#troubleshooting-cft" role="tab" aria-controls="troubleshooting-cft" aria-expanded="false">
        CFT
      </a>
    </li>
    <li class="app-tabs__item js-tabs__item app-tabs__item--current" role="presentation">
      <a href="#troubleshooting-sds" role="tab" aria-controls="troubleshooting-sds" aria-expanded="true">
      SDS
      </a>
    </li>
  </ul>
  <div class="app-tabs__heading js-tabs__heading">
    <button aria-controls="troubleshooting-cft" class="app-tabs__heading-button">CFT</button>
  </div>
  <div class="app-tabs__container js-tabs__container app-tabs__container--hidden" id="troubleshooting-cft" role="tabpanel" aria-hidden="true">
    <div class="app-example__code">
      <pre data-module="app-copy" tabindex="0">
        <code>
  # Preview (only one cluster is active at a given time)
  az aks get-credentials --resource-group cft-preview-00-rg --name cft-preview-00-aks --subscription DCD-CFTAPPS-DEV
  az aks get-credentials --resource-group cft-preview-01-rg --name cft-preview-01-aks --subscription DCD-CFTAPPS-DEV

  # AAT
  az aks get-credentials --resource-group cft-aat-00-rg --name cft-aat-00-aks --subscription DCD-CFTAPPS-STG
  az aks get-credentials --resource-group cft-aat-01-rg --name cft-aat-01-aks --subscription DCD-CFTAPPS-STG

  # Perftest
  az aks get-credentials --resource-group cft-perftest-00-rg --name cft-perftest-00-aks --subscription DCD-CFTAPPS-TEST
  az aks get-credentials --resource-group cft-perftest-01-rg --name cft-perftest-01-aks --subscription DCD-CFTAPPS-TEST

  # ITHC
  az aks get-credentials --resource-group cft-ithc-00-rg --name cft-ithc-00-aks --subscription DCD-CFTAPPS-ITHC
  az aks get-credentials --resource-group cft-ithc-01-rg --name cft-ithc-01-aks --subscription DCD-CFTAPPS-ITHC
  
  # Demo
  az aks get-credentials --resource-group cft-demo-00-rg --name cft-demo-00-aks --subscription DCD-CFTAPPS-DEMO
  
  # Prod (Requires additional permissions)
  az aks get-credentials --resource-group prod-00-rg --name prod-00-aks --subscription DCD-CFTAPPS-PROD
  az aks get-credentials --resource-group prod-01-rg --name prod-01-aks --subscription DCD-CFTAPPS-PROD
  
  # CFTPTL (Prod management)
  az aks get-credentials --resource-group cft-ptl-00-rg --name cft-ptl-00-aks --subscription DTS-CFTPTL-INTSVC
</code></pre>
    </div>
  </div>
  
  <div class="app-tabs__heading js-tabs__heading app-tabs__heading--current">
    <button aria-controls="troubleshooting-sds" class="app-tabs__heading-button" aria-expanded="true">SDS</button>
  </div>

  <div class="app-tabs__container js-tabs__container" id="troubleshooting-sds" role="tabpanel" aria-hidden="false">
    <div>
      <pre data-module="app-copy" tabindex="0">
        <code>
  # Dev (only one cluster is active at a given time)
  az aks get-credentials --resource-group ss-dev-00-rg --name ss-dev-00-aks --subscription DTS-SHAREDSERVICES-DEV
  az aks get-credentials --resource-group ss-dev-01-rg --name ss-dev-01-aks --subscription DTS-SHAREDSERVICES-DEV
  
  # Staging
  az aks get-credentials --resource-group ss-stg-00-rg --name ss-stg-00-aks --subscription DTS-SHAREDSERVICES-STG
  az aks get-credentials --resource-group ss-stg-01-rg --name ss-stg-01-aks --subscription DTS-SHAREDSERVICES-STG

  # Test
  az aks get-credentials --resource-group ss-test-00-rg --name ss-test-00-aks --subscription DTS-SHAREDSERVICES-TEST
  az aks get-credentials --resource-group ss-test-01-rg --name ss-test-01-aks --subscription DTS-SHAREDSERVICES-TEST
  
  # ITHC
  az aks get-credentials --resource-group ss-ithc-00-rg --name ss-ithc-00-aks --subscription DTS-SHAREDSERVICES-ITHC
  az aks get-credentials --resource-group ss-ithc-01-rg --name ss-ithc-01-aks --subscription DTS-SHAREDSERVICES-ITHC
  
  # Demo (only one cluster is active at a given time)
  az aks get-credentials --resource-group ss-demo-00-rg --name ss-demo-00-aks --subscription DTS-SHAREDSERVICES-DEMO
  az aks get-credentials --resource-group ss-demo-01-rg --name ss-demo-01-aks --subscription DTS-SHAREDSERVICES-DEMO
  
  # Prod (Requires additional permissions)
  az aks get-credentials --resource-group ss-prod-00-rg --name ss-prod-00-aks --subscription DTS-SHAREDSERVICES-PROD
  az aks get-credentials --resource-group ss-prod-01-rg --name ss-prod-01-aks --subscription DTS-SHAREDSERVICES-PROD
  
  # SDSPTL (Prod management)
  az aks get-credentials --resource-group ss-ptl-00-rg --name ss-ptl-00-aks --subscription DTS-SHAREDSERVICESPTL  
</code></pre>
    </div>
  </div>
</div>
