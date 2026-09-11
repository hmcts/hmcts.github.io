# Local Terraform catalogue proof of concept

Each directory in `terraform-modules/` is a small stand-in for an independently owned
Terraform module repository. It contains the module's `.hmcts/catalogue.yaml` metadata
and a basic Terraform example.

The metadata is intentionally complete: it declares the repository URL and default branch,
archived state, discovery topics, recommended module version, and Terraform/provider
requirements alongside the human context needed to choose a module.

Each fixture also declares whether it is `self-service` or `contribution-required`. This
tells service teams whether they can deploy it from their own Terraform or must propose a
configuration pull request to a shared platform component.

Run `bundle exec rake catalogue:refresh_local` from the repository root to validate and
generate `data/terraform_modules.yml` from these local fixtures. No GitHub token or
network access is needed.

These modules are deliberately not production infrastructure. Their purpose is to make
the catalogue workflow and its lifecycle states visible locally. The metadata's `owner`
field records stewardship: it identifies an appropriate reviewer and support route, not an
exclusive owner of a shared platform asset.
