output "dashboard_group_id" {
  description = "The ID of the nagios dashboard group"
  value       = signalfx_dashboard_group.nagios.id
}

output "dashboard_id" {
  description = "The ID(s) of overview dashboard"
  value       = signalfx_dashboard.nagiosoverview.id
}

