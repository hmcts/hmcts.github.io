# Platform Catalogue POC: local build

## What this POC demonstrates

The catalogue is generated from Terraform module metadata, rather than maintained by hand
in HMCTS Way. The local fixture repositories in `poc/terraform-modules/` demonstrate
five supported modules across common categories, plus one deprecated module with an
approved replacement. Their `owner` metadata identifies stewardship and a support route;
the modules remain shared assets that anyone can improve through a normal pull request.

Each fixture's catalogue record is complete and self-describing: it includes repository
URL, default branch, archived state, topics, recommended version, and Terraform/provider
requirements rather than relying on enrichment from GitHub or Terraform source files.
The `consumption` block makes the deployment route explicit: self-service or a
configuration pull request to a shared platform component.

## Run locally

From the repository root:

```sh
bundle install
bundle exec rake catalogue:refresh_local
bundle exec middleman server
```

Open `http://localhost:4567/platform-catalogue/terraform-modules/`. The local refresh
rewrites `data/terraform_modules.yml`; it does not use the GitHub API, an App token, or
network access.

To make a static build instead, run:

```sh
bundle exec rake catalogue:refresh_local
bundle exec middleman build
bundle exec rake check_pages
```

## How the production refresh differs

`bundle exec rake catalogue:refresh` discovers `hmcts` repositories tagged
`terraform-module`, follows all GitHub API result pages, and reads
`.hmcts/catalogue.yaml` from each repository's default branch.

The scheduled GitHub workflow uses the repository `GITHUB_TOKEN`, which can read every
public hmcts repository — all currently catalogued modules are public. If private module
repositories ever need cataloguing, switch the workflow to an organisation-installed
GitHub App token (`actions/create-github-app-token`) with read access to those
repositories; the repository `GITHUB_TOKEN` cannot read private organisation repos.

The workflow fails without changing catalogue data if discovery fails, and it fails rather
than generating an incomplete catalogue if the GitHub topic exceeds the search API's
1,000-repository limit.
