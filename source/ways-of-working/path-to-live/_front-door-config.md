<div class="platform-selector" id="front-door-config-clusters" data-module="app-tabs">
  <ul class="app-tabs" role="tablist">
    <li class="app-tabs__item js-tabs__item js-tabs__item--open" role="presentation">
      <a href="#front-door-config-cft" role="tab" aria-controls="front-door-config-cft" aria-expanded="false">
        CFT
      </a>
    </li>
    <li class="app-tabs__item js-tabs__item app-tabs__item--current" role="presentation">
      <a href="#front-door-config-sds" role="tab" aria-controls="front-door-config-sds" aria-expanded="true">
      SDS
      </a>
    </li>
  </ul>
  <div class="app-tabs__heading js-tabs__heading">
    <button aria-controls="front-door-config-cft" class="app-tabs__heading-button">CFT</button>
  </div>
  <div class="app-tabs__container js-tabs__container app-tabs__container--hidden" id="front-door-config-cft" role="tabpanel" aria-hidden="true">
    <div class="app-example__code">
      Configuration is located in
      <a href="https://github.com/hmcts/azure-platform-terraform/blob/master/environments/prod/prod.tfvars">azure-platform-terraform</a>.
      <p>A minimal configuration for production would be:</p>
      <pre data-module="app-copy" tabindex="0">
  <code>{
    product                     = "product"
    name                        = "app-name"
    custom_domain               = "your-app.service.gov.uk"
    backend_domain              = ["firewall-prod-int-palo-cftprod.uksouth.cloudapp.azure.com"]
  }
</code></pre>
    </div>
  </div>
  
  <div class="app-tabs__heading js-tabs__heading app-tabs__heading--current">
    <button aria-controls="front-door-config-sds" class="app-tabs__heading-button" aria-expanded="true">SDS</button>
  </div>

  <div class="app-tabs__container js-tabs__container" id="front-door-config-sds" role="tabpanel" aria-hidden="false">
    <div>
      Configuration is located in 
      <a href="https://github.com/hmcts/sds-azure-platform/blob/master/environments/prod/prod.tfvars">sds-azure-platform</a>.
      <p>A minimal configuration for production would be:</p>
      <pre data-module="app-copy" tabindex="0">
  <code>{
    name             = "app-name"
    custom_domain    = "your-app.service.gov.uk"
    backend_domain   = ["firewall-prod-int-palo-sdsprod.uksouth.cloudapp.azure.com"]
  }
</code></pre>
    </div>
  </div>
</div>


For the other options available have a look at what other applications are using in the same file.

