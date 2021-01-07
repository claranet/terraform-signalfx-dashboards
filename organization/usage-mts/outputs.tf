output "dashboard_group_id" {
  description = "The ID of the usage dashboard group"
  value       = signalfx_dashboard_group.usage-mts.id
}

output "dashboard_id" {
  description = "The ID(s) of each dashboard"
  value       = signalfx_dashboard.usage-mts.id
}

