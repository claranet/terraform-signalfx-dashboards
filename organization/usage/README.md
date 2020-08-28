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
  container_ratio_detector = {
    id   = tostring(module.signalfx-detectors-organization-usage.container_ratio_id[0]),
    name = module.signalfx-detectors-organization-usage.container_ratio_name[0],
  }
}

module "signalfx-dashboards-organization-usage" {
  source = "github.com/claranet/terraform-signalfx-dashboards.git//organization/usage?ref=usage"

  container_ratio_detector = local.container_ratio_detector
}

```

This will brings alerts directly into dashboard charts:

![](././img/detector_link.png)
