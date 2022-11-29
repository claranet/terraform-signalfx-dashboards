output "dashboard_group_id" {
  description = "The ID of the nginx ingress dashboard group"
  value       = signalfx_dashboard_group.nginx_ingress.id
}

output "dashboard_id" {
  description = "The ID(s) of overview dashboard"
  value       = signalfx_dashboard.nginx_ingress.id
}

