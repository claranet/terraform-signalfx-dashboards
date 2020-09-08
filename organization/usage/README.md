# Orgnization usage dashboards

![](././img/dashboard_child.png)

## Detectors links

This is possible to add [detectors](https://github.com/claranet/terraform-signalfx-detectors/tree/master/organization/usage) links to their corresponding chart:

```hcl
module "signalfx-detectors-organization-usage" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//organization/usage"

  notifications = ["Email,billing@mycorp.net"]
}

locals {
  detectors = {
    hosts_limit = module.signalfx-detectors-organization-usage.hosts_limit
    containers_limit = module.signalfx-detectors-organization-usage.containers_limit
    custom_metrics_limit = module.signalfx-detectors-organization-usage.custom_metrics_limit
    containers_ratio = module.signalfx-detectors-organization-usage.containers_ratio
    custom_metrics_ratio = module.signalfx-detectors-organization-usage.custom_metrics_ratio
  }
}

module "signalfx-dashboards-organization-usage" {
  source = "github.com/claranet/terraform-signalfx-dashboards.git//organization/usage"

  detectors = local.detectors
  #is_parent = false # Uncomment if deployed on child org
}

```

This will brings alerts directly into dashboard charts:

![](./img/detector_link.png)

## Notes

- Default configuration is for multi orgs usage visibility. Toggle the `is_parent` flag to `false` for one specific child org.
- When `is_parent` is `true` 2 dashboards are created allowing per "child" overview or "parent" global overview.
- When `is_parent` is `false` only one dashboard will be created similary to "parent" but simply named "org".
- Variable `default_org_name` is required to get data on "child" dashboard without to have to change the filter manually everytime.
- Variable `default_org_name` has no effect when `is_parent` is `false` while there is only one org.
- Detectors are optional but brings alerts directly into relavant dashboard ("child" when `is_parent` is `true`).
- If detectors are set, links will be added to "parent" dashboard charts only when `is_parent` is `true`.

