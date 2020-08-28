resource "signalfx_single_value_chart" "child_hosts_current" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Hosts"
  program_text            = "A = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'host')).mean(over='15m').publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "lilac"
    display_name = "Hosts"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "child_containers_current" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Containers"
  program_text            = "A = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'container')).mean(over='15m').publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "blue"
    display_name = "Containers"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "child_custom_metrics_current" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Custom metrics"
  program_text            = "A = data('sf.org.numCustomMetrics').mean(over='15m').publish(label='A')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "orange"
    display_name = "Custom metrics"
    label        = "A"
  }
}

resource "signalfx_time_chart" "child_hosts_limit" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Hosts compared to organization limit"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'host')).publish(label='A')
        B = data('sf.org.subscription.hosts').publish(label='B')
        ${var.hosts_limit_detector != null ? "alerts = alerts(detector_id='${var.hosts_limit_detector["id"]}').publish(label='alerts')" : ""}
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 2678400
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  dynamic "event_options" {
    for_each = var.hosts_limit_detector != null ? compact([var.hosts_limit_detector["name"]]) : []
    content {
      display_name = var.hosts_limit_detector["name"]
      label        = "alerts"
    }
  }

  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Limit"
    label        = "B"
    plot_type    = "LineChart"
  }
  viz_options {
    axis         = "left"
    color        = "lilac"
    display_name = "Hosts"
    label        = "A"
  }
}

resource "signalfx_time_chart" "child_containers_limit" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Containers compared to organization limit"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'container')).publish(label='A')
        B = data('sf.org.subscription.containers').publish(label='B')
        ${var.containers_limit_detector != null ? "alerts = alerts(detector_id='${var.containers_limit_detector["id"]}').publish(label='alerts')" : ""}
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 2678400
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  dynamic "event_options" {
    for_each = var.containers_limit_detector != null ? compact([var.containers_limit_detector["name"]]) : []
    content {
      display_name = var.containers_limit_detector["name"]
      label        = "alerts"
    }
  }

  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Limit"
    label        = "B"
    plot_type    = "LineChart"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "Containers"
    label        = "A"
  }
}

resource "signalfx_time_chart" "child_custom_metrics_limit" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Custom metrics compared to organization limit"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('sf.org.numCustomMetrics').publish(label='A')
        B = data('sf.org.subscription.customMetrics').publish(label='B')
        ${var.custom_metrics_limit_detector != null ? "alerts = alerts(detector_id='${var.custom_metrics_limit_detector["id"]}').publish(label='alerts')" : ""}
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 2678400
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  dynamic "event_options" {
    for_each = var.custom_metrics_limit_detector != null ? compact([var.custom_metrics_limit_detector["name"]]) : []
    content {
      display_name = var.custom_metrics_limit_detector["name"]
      label        = "alerts"
    }
  }

  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Limit"
    label        = "B"
    plot_type    = "LineChart"
  }
  viz_options {
    axis         = "left"
    color        = "orange"
    display_name = "Custom metrics"
    label        = "A"
  }
}

resource "signalfx_time_chart" "child_containers_ratio" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Containers per host ratio evolution"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'container')).publish(label='A', enable=False)
        B = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'host')).publish(label='B', enable=False)
        C = (A / (B*${var.multiplier}0)).scale(100).publish(label='C')
        D = (A-A+100).publish(label='D')
        ${var.containers_ratio_detector != null ? "alerts = alerts(detector_id='${var.containers_ratio_detector["id"]}').publish(label='alerts')" : ""}
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 2678400
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  dynamic "event_options" {
    for_each = var.containers_ratio_detector != null ? compact([var.containers_ratio_detector["name"]]) : []
    content {
      display_name = var.containers_ratio_detector["name"]
      label        = "alerts"
    }
  }

  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Threshold"
    label        = "D"
    plot_type    = "LineChart"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "Ratio"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Hosts"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "Containers"
    label        = "A"
  }
}

resource "signalfx_time_chart" "child_custom_metrics_ratio" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Custom metrics per host ratio evolution"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('sf.org.numCustomMetrics').publish(label='A', enable=False)
        B = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'host')).publish(label='B', enable=False)
        C = (A / (B*${var.multiplier}0)).scale(100).publish(label='C')
        D = (A-A+100).publish(label='D')
        ${var.custom_metrics_ratio_detector != null ? "alerts = alerts(detector_id='${var.custom_metrics_ratio_detector["id"]}').publish(label='alerts')" : ""}
    EOF
  show_data_markers  = false
  show_event_lines   = false
  stacked            = false
  time_range         = 2678400
  unit_prefix        = "Metric"

  histogram_options {
    color_theme = "red"
  }

  dynamic "event_options" {
    for_each = var.custom_metrics_ratio_detector != null ? compact([var.custom_metrics_ratio_detector["name"]]) : []
    content {
      display_name = var.custom_metrics_ratio_detector["name"]
      label        = "alerts"
    }
  }

  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Threshold"
    label        = "D"
    plot_type    = "LineChart"
  }
  viz_options {
    axis         = "left"
    color        = "orange"
    display_name = "Ratio"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Hosts"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    color        = "blue"
    display_name = "Containers"
    label        = "A"
  }
}

resource "signalfx_dashboard" "child_child" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.usage.id
  name              = "Child organization"
  time_range        = "-31d"

  chart {
    chart_id = signalfx_single_value_chart.custom_metrics_current.id
    column   = 7
    height   = 1
    row      = 0
    width    = 5
  }
  chart {
    chart_id = signalfx_single_value_chart.containers_current.id
    column   = 3
    height   = 1
    row      = 0
    width    = 4
  }
  chart {
    chart_id = signalfx_single_value_chart.hosts_current.id
    column   = 0
    height   = 1
    row      = 0
    width    = 3
  }
  chart {
    chart_id = signalfx_time_chart.custom_metrics_ratio.id
    column   = 6
    height   = 1
    row      = 2
    width    = 6
  }
  chart {
    chart_id = signalfx_time_chart.hosts_limit.id
    column   = 0
    height   = 1
    row      = 1
    width    = 4
  }
  chart {
    chart_id = signalfx_time_chart.custom_metrics_limit.id
    column   = 8
    height   = 1
    row      = 1
    width    = 4
  }
  chart {
    chart_id = signalfx_time_chart.containers_limit.id
    column   = 4
    height   = 1
    row      = 1
    width    = 4
  }
  chart {
    chart_id = signalfx_time_chart.containers_ratio.id
    column   = 0
    height   = 1
    row      = 2
    width    = 6
  }

  variable {
    alias                  = "Child org name"
    apply_if_exist         = false
    property               = "childOrgName"
    replace_only           = false
    restricted_suggestions = false
    value_required         = true
    values = [
      var.default_org_name,
    ]
    values_suggested = []
  }
}
