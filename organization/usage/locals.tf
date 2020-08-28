locals {
  dashboards = var.is_parent ? { child = { is_parent = true, alerts = true }, parent = { is_parent = false, alerts = false } } : { org = { is_parent = false, alerts = true } }
}
