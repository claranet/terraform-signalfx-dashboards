resource "signalfx_dashboard_group" "usage" {
  name = "SignalFx organizations usage and billing"
}

module "dashboard_usage" {
  source   = "./dashboard-usage"
  for_each = local.dashboards

  dashboard_group  = signalfx_dashboard_group.usage.id
  name             = each.key
  is_parent        = each.value.is_parent
  default_org_name = var.default_org_name
  detectors = each.value.alerts ? var.detectors : {}
}

