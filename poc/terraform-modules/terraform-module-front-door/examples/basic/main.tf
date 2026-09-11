module "front_door" {
  source      = "../.."
  project     = "example-hmcts-service"
  environment = "development"

  frontends = [
    {
      custom_domain  = "example.service.gov.uk"
      backend_domain = ["example.azurewebsites.net"]
    }
  ]
}

# DNS stays with the consuming service or DNS zone configuration. The real
# terraform-module-frontdoor repository includes a commented CNAME example;
# it does not create the DNS record as part of the module.
