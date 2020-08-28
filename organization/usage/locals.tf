locals {
  #dashboards = var.is_parent ? {child = merge({is_parent=true}, var.detectors)} : {org = merge({is_parent=false}, var.detectors)}
  dashboards = var.is_parent ? {child = {is_parent=true}} : {org = {is_parent=false}}
}
