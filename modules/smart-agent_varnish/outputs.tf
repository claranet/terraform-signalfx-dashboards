output "dashboard_group_id" {
  description = "The ID of the varnish dashboard group"
  value       = signalfx_dashboard_group.varnish.id
}

output "dashboard_id" {
  description = "The ID of the overview dashboard"
  value       = signalfx_dashboard.varnish.id
}

