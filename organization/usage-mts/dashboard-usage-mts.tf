# signalfx_list_chart.usage-mts_0:
resource "signalfx_list_chart" "usage-mts_0" {
  color_by            = "Metric"
  disable_sampling    = false
  hide_missing_values = true
  max_delay           = 0
  max_precision       = 4
  name                = "Monthly stats"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["monthly"], publish = merge(local.publish, { HOSTS = "True", MTS = "True" }) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, {
    HOSTS  = "True"
    MTS    = "True"
    MTSB   = "True"
    HOSTSB = "True"
    LIC    = "True"
    PRICE  = "True"
    MTSH   = "True"
    MTSBP  = "True"
    LICBP  = "True"
    AVGMTS = "True"
  }), licence = local.licence })
)}
    EOF
secondary_visualization = "None"
sort_by                 = "+sf_metric"
time_range              = 2678400
unit_prefix             = "Metric"

legend_options_fields {
  enabled  = false
  property = "sf_originatingMetric"
}
legend_options_fields {
  enabled  = false
  property = "orgId"
}
legend_options_fields {
  enabled  = true
  property = "sf_metric"
}
legend_options_fields {
  enabled  = false
  property = "childOrgId"
}
legend_options_fields {
  enabled  = false
  property = "childOrgName"
}

viz_options {
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_single_value_chart.usage-mts_1:
resource "signalfx_single_value_chart" "usage-mts_1" {
  color_by            = "Metric"
  is_timestamp_hidden = true
  max_delay           = 0
  max_precision       = 0
  name                = "Current usage price"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["last"], publish = merge(local.publish, {}) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, { PRICE = "True" }), licence = local.licence })
)}
    EOF
secondary_visualization = "None"
show_spark_line         = false
unit_prefix             = "Metric"

viz_options {
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_single_value_chart.usage-mts_2:
resource "signalfx_single_value_chart" "usage-mts_2" {
  color_by            = "Metric"
  is_timestamp_hidden = true
  max_delay           = 0
  max_precision       = 0
  name                = "Current licences count"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["last"], publish = merge(local.publish, {}) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, { LIC = "True" }), licence = local.licence })
)}
    EOF
secondary_visualization = "None"
show_spark_line         = false
unit_prefix             = "Metric"

viz_options {
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_single_value_chart.usage-mts_3:
resource "signalfx_single_value_chart" "usage-mts_3" {
  color_by            = "Metric"
  is_timestamp_hidden = true
  max_delay           = 0
  max_precision       = 0
  name                = "Current MTS in Burst"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["last"], publish = merge(local.publish, {}) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, { MTSB = "True" }), licence = local.licence })
)}
    EOF
secondary_visualization = "None"
show_spark_line         = false
unit_prefix             = "Metric"

viz_options {
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_time_chart.usage-mts_4:
resource "signalfx_time_chart" "usage-mts_4" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Metric"
  disable_sampling          = false
  max_delay                 = 0
  minimum_resolution        = 0
  name                      = "Licences"
  on_chart_legend_dimension = "plot_label"
  plot_type                 = "ColumnChart"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["last"], publish = merge(local.publish, { HOSTS = "True" }) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, { HOSTSB = "True" }), licence = local.licence })
)}
    EOF
show_data_markers = false
show_event_lines  = false
stacked           = true
time_range        = 2678400
unit_prefix       = "Metric"

histogram_options {
  color_theme = "red"
}

legend_options_fields {
  enabled  = false
  property = "sf_originatingMetric"
}
legend_options_fields {
  enabled  = false
  property = "orgId"
}
legend_options_fields {
  enabled  = true
  property = "sf_metric"
}

viz_options {
  axis         = "left"
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  axis         = "left"
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  axis         = "left"
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  axis         = "left"
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  axis         = "left"
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  axis         = "left"
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  axis         = "left"
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  axis         = "left"
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  axis         = "left"
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  axis         = "left"
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_single_value_chart.usage-mts_5:
resource "signalfx_single_value_chart" "usage-mts_5" {
  color_by            = "Scale"
  is_timestamp_hidden = true
  max_delay           = 0
  max_precision       = 4
  name                = "Current average MTS / Host"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["last"], publish = merge(local.publish, {}) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, { HOSTSB = "True" }), licence = local.licence })
)}
    EOF
secondary_visualization = "Linear"
show_spark_line         = false
unit_prefix             = "Metric"

color_scale {
  color = "lime_green"
  gt    = 340282346638528860000000000000000000000
  gte   = 0
  lt    = 340282346638528860000000000000000000000
  lte   = 84
}
color_scale {
  color = "red"
  gt    = 168
  gte   = 340282346638528860000000000000000000000
  lt    = 340282346638528860000000000000000000000
  lte   = 300
}
color_scale {
  color = "vivid_yellow"
  gt    = 84
  gte   = 340282346638528860000000000000000000000
  lt    = 340282346638528860000000000000000000000
  lte   = 168
}

viz_options {
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_time_chart.usage-mts_6:
resource "signalfx_time_chart" "usage-mts_6" {
  axes_include_zero         = false
  axes_precision            = 0
  color_by                  = "Metric"
  disable_sampling          = false
  max_delay                 = 0
  minimum_resolution        = 0
  name                      = "MTS"
  on_chart_legend_dimension = "plot_label"
  plot_type                 = "ColumnChart"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["last"], publish = merge(local.publish, {}) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, { MTSB = "True", MTSH = "True" }), licence = local.licence })
)}
    EOF
show_data_markers = false
show_event_lines  = false
stacked           = true
time_range        = 2678400
unit_prefix       = "Metric"

histogram_options {
  color_theme = "red"
}

legend_options_fields {
  enabled  = false
  property = "sf_originatingMetric"
}
legend_options_fields {
  enabled  = false
  property = "orgId"
}
legend_options_fields {
  enabled  = true
  property = "sf_metric"
}

viz_options {
  axis         = "left"
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  axis         = "left"
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  axis         = "left"
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  axis         = "left"
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  axis         = "left"
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  axis         = "left"
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  axis         = "left"
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  axis         = "left"
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  axis         = "left"
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  axis         = "left"
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_single_value_chart.usage-mts_7:
resource "signalfx_single_value_chart" "usage-mts_7" {
  color_by            = "Scale"
  is_timestamp_hidden = true
  max_delay           = 0
  max_precision       = 4
  name                = "% of Burst"
  program_text = <<-EOF
    ${format("%s%s",
  templatefile(format("${path.module}/%s", var.is_parent ? local.templates["parent"] : local.templates["child"]), { aggregation = local.aggregations["last"], publish = merge(local.publish, {}) }),
  templatefile(format("${path.module}/%s", local.templates["common"]), { publish = merge(local.publish, { MTSBP = "True" }), licence = local.licence })
)}
    EOF
secondary_visualization = "Radial"
show_spark_line         = false
unit_prefix             = "Metric"

color_scale {
  color = "lime_green"
  gt    = 340282346638528860000000000000000000000
  gte   = 0
  lt    = 340282346638528860000000000000000000000
  lte   = 25
}
color_scale {
  color = "red"
  gt    = 50
  gte   = 340282346638528860000000000000000000000
  lt    = 340282346638528860000000000000000000000
  lte   = 100
}
color_scale {
  color = "vivid_yellow"
  gt    = 25
  gte   = 340282346638528860000000000000000000000
  lt    = 340282346638528860000000000000000000000
  lte   = 50
}

viz_options {
  color        = "aquamarine"
  display_name = "Estimated price"
  label        = "PRICE"
  value_prefix = "$"
}
viz_options {
  color        = "brown"
  display_name = "MTS in Burst"
  label        = "MTSB"
}
viz_options {
  color        = "emerald"
  display_name = "Average MTS / Host"
  label        = "AVGMTS"
}
viz_options {
  color        = "gray"
  display_name = "MTS in Hosts"
  label        = "MTSH"
}
viz_options {
  color        = "lilac"
  display_name = "Licenses"
  label        = "LIC"
}
viz_options {
  color        = "magenta"
  display_name = "Licences in Burst"
  label        = "HOSTSB"
}
viz_options {
  color        = "navy"
  display_name = "Licenses in Hosts"
  label        = "HOSTS"
}
viz_options {
  color        = "orange"
  display_name = "% of Licences Burst"
  label        = "LICBP"
  value_suffix = "%"
}
viz_options {
  color        = "purple"
  display_name = "MTS total"
  label        = "MTS"
}
viz_options {
  color        = "yellow"
  display_name = "% of MTS Burst"
  label        = "MTSBP"
  value_suffix = "%"
}
}
# signalfx_dashboard.usage-mts:
resource "signalfx_dashboard" "usage-mts" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.usage-mts.id
  name              = var.is_parent ? "Child" : "Overview"
  time_range        = "-31d"

  dynamic "variable" {
    for_each = var.is_parent ? [true] : []
    content {
      alias                  = "ChildOrg"
      apply_if_exist         = false
      description            = "The Child Organization name"
      property               = "childOrgName"
      replace_only           = false
      restricted_suggestions = false
      value_required         = true
      values = [
        "Openclassrooms",
      ]
    }
  }

  chart {
    chart_id = signalfx_time_chart.usage-mts_4.id
    column   = 3
    height   = 1
    row      = 1
    width    = 6
  }
  chart {
    chart_id = signalfx_single_value_chart.usage-mts_3.id
    column   = 9
    height   = 1
    row      = 0
    width    = 3
  }
  chart {
    chart_id = signalfx_time_chart.usage-mts_6.id
    column   = 3
    height   = 1
    row      = 2
    width    = 6
  }
  chart {
    chart_id = signalfx_single_value_chart.usage-mts_1.id
    column   = 3
    height   = 1
    row      = 0
    width    = 3
  }
  chart {
    chart_id = signalfx_single_value_chart.usage-mts_2.id
    column   = 6
    height   = 1
    row      = 0
    width    = 3
  }
  chart {
    chart_id = signalfx_list_chart.usage-mts_0.id
    column   = 0
    height   = 3
    row      = 0
    width    = 3
  }
  chart {
    chart_id = signalfx_single_value_chart.usage-mts_5.id
    column   = 9
    height   = 1
    row      = 1
    width    = 3
  }
  chart {
    chart_id = signalfx_single_value_chart.usage-mts_7.id
    column   = 9
    height   = 1
    row      = 2
    width    = 3
  }
}
