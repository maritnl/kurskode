locals {
  domain_name = data.azuread_domains.default.domains.0.domain_name
}