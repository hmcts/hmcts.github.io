<div class="platform-selector" id="front-door-endpoint-clusters" data-module="app-tabs">
  <ul class="app-tabs" role="tablist">
    <li class="app-tabs__item js-tabs__item js-tabs__item--open" role="presentation">
      <a href="#front-door-endpoint-cft" role="tab" aria-controls="front-door-endpoint-cft" aria-expanded="false">
        CFT
      </a>
    </li>
    <li class="app-tabs__item js-tabs__item app-tabs__item--current" role="presentation">
      <a href="#front-door-endpoint-sds" role="tab" aria-controls="front-door-endpoint-sds" aria-expanded="true">
      SDS
      </a>
    </li>
  </ul>
  <div class="app-tabs__heading js-tabs__heading">
    <button aria-controls="front-door-endpoint-cft" class="app-tabs__heading-button">CFT</button>
  </div>
  <div class="app-tabs__container js-tabs__container app-tabs__container--hidden" id="front-door-endpoint-cft" role="tabpanel" aria-hidden="true">
    <div class="app-example__code">
      <pre data-module="app-copy" tabindex="0">
        <code>
  # Sandbox
  hmcts-sbox-gufqadefbjgbhkhv.z01.azurefd.net

  # Preview (only used in very limited use-cases for FrontDoor)
  hmcts-preview-fkhfehdgahcrhbds.z01.azurefd.net

  # AAT
  hmcts-aat-dbdveha6dnc7ejdt.z01.azurefd.net

  # Perftest
  hmcts-perftest-c5g8ard0d4c5cdd9.z01.azurefd.net

  # ITHC
  hmcts-ithc-h2aabtenhae2aqda.z01.azurefd.net
  
  # Demo
  hmcts-demo-hpfvc6a4frdsdtbc.z01.azurefd.net
  
  # Prod (Requires additional permissions)
  COMING SOON

</code></pre>
    </div>
  </div>
  
  <div class="app-tabs__heading js-tabs__heading app-tabs__heading--current">
    <button aria-controls="front-door-endpoint-sds" class="app-tabs__heading-button" aria-expanded="true">SDS</button>
  </div>

  <div class="app-tabs__container js-tabs__container" id="front-door-endpoint-sds" role="tabpanel" aria-hidden="false">
    <div>
      <pre data-module="app-copy" tabindex="0">
        <code>
  # Sandbox
  sdshmcts-sbox-bueqa6a6hefjfne4.z01.azurefd.net

  # Dev (only used in very limited use-cases for FrontDoor)
  sdshmcts-dev-c4ercybwaubzbmfn.z01.azurefd.net
  
  # Staging
  sdshmcts-stg-abfwhrf8g0btcqhe.z01.azurefd.net

  # Test
  sdshmcts-test-a2d9enhbenftckhu.z01.azurefd.net
  
  # ITHC
  sdshmcts-ithc-hjd8acedcyeygkgk.z01.azurefd.net
  
  # Demo
  sdshmcts-demo-d9brfxgseqf0cpen.z01.azurefd.net
  
  # Prod (Requires additional permissions)
  COMING SOON
   
</code></pre>
    </div>
  </div>
</div>
