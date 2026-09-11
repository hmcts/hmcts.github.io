module "legacy_private_dns" {
  source    = "../.."
  zone_name = "privatelink.example.internal"
}
