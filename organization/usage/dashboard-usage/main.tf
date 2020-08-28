resource "signalfx_single_value_chart" "hosts_current" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Hosts"
  program_text            = "A = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored', filter=filter('resourceType', 'host')).mean(over='15m').publish(label='A"}')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "lilac"
    display_name = "Hosts"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "containers_current" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Containers"
  program_text            = "A = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored', filter=filter('resourceType', 'container')).mean(over='15m').publish(label='A"}')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "blue"
    display_name = "Containers"
    label        = "A"
  }
}

resource "signalfx_single_value_chart" "custom_metrics_current" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Custom metrics"
  program_text            = "A = data('${"sf.org.${var.is_parent ? "child." : ""}numCustomMetrics').mean(over='15m').publish(label='A"}')"
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    color        = "orange"
    display_name = "Custom metrics"
    label        = "A"
  }
}

resource "signalfx_time_chart" "hosts_limit" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Hosts compared to organization limit"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored', filter=filter('resourceType', 'host')).publish(label='A"}')
        B = data('${"sf.org.${var.is_parent ? "child." : ""}subscription.hosts').publish(label='B"}')
        ${var.detectors["hosts_limit"] != null ? "alerts = alerts(detector_id='${var.detectors["hosts_limit"]["id"]}').publish(label='alerts')" : ""}
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
    for_each = var.detectors["hosts_limit"] != null ? compact([var.detectors["hosts_limit"]["name"]]) : []
    content {
      display_name = var.detectors["hosts_limit"]["name"]
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

resource "signalfx_time_chart" "containers_limit" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Containers compared to organization limit"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored', filter=filter('resourceType', 'container')).publish(label='A"}')
        B = data('${"sf.org.${var.is_parent ? "child." : ""}subscription.containers').publish(label='B"}')
        ${var.detectors["containers_limit"] != null ? "alerts = alerts(detector_id='${var.detectors["containers_limit"]["id"]}').publish(label='alerts')" : ""}
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
    for_each = var.detectors["containers_limit"] != null ? compact([var.detectors["containers_limit"]["name"]]) : []
    content {
      display_name = var.detectors["containers_limit"]["name"]
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

resource "signalfx_time_chart" "custom_metrics_limit" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Custom metrics compared to organization limit"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('${"sf.org.${var.is_parent ? "child." : ""}numCustomMetrics').publish(label='A"}')
        B = data('${"sf.org.${var.is_parent ? "child." : ""}subscription.customMetrics').publish(label='B"}')
        ${var.detectors["custom_metrics_limit"] != null ? "alerts = alerts(detector_id='${var.detectors["custom_metrics_limit"]["id"]}').publish(label='alerts')" : ""}
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
    for_each = var.detectors["custom_metrics_limit"] != null ? compact([var.detectors["custom_metrics_limit"]["name"]]) : []
    content {
      display_name = var.detectors["custom_metrics_limit"]["name"]
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

resource "signalfx_time_chart" "containers_ratio" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Containers per host ratio evolution"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored', filter=filter('resourceType', 'container"}')).publish(label='A', enable=False)
        B = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored', filter=filter('resourceType', 'host"}')).publish(label='B', enable=False)
        C = (A / (B*${var.multiplier}0)).scale(100).publish(label='C')
        D = (A-A+100).publish(label='D')
        ${var.detectors["containers_ratio"] != null ? "alerts = alerts(detector_id='${var.detectors["containers_ratio"]["id"]}').publish(label='alerts')" : ""}
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
    for_each = var.detectors["containers_ratio"] != null ? compact([var.detectors["containers_ratio"]["name"]]) : []
    content {
      display_name = var.detectors["containers_ratio"]["name"]
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

resource "signalfx_time_chart" "custom_metrics_ratio" {
  axes_include_zero  = false
  axes_precision     = 0
  color_by           = "Metric"
  disable_sampling   = false
  minimum_resolution = 0
  name               = "Custom metrics per host ratio evolution"
  plot_type          = "AreaChart"
  program_text       = <<-EOF
        A = data('${"sf.org.${var.is_parent ? "child." : ""}numCustomMetrics"}').publish(label='A', enable=False)
        B = data('${"sf.org.${var.is_parent ? "child." : ""}numResourcesMonitored', filter=filter('resourceType', 'host"}')).publish(label='B', enable=False)
        C = (A / (B*${var.multiplier}0)).scale(100).publish(label='C')
        D = (A-A+100).publish(label='D')
        ${var.detectors["custom_metrics_ratio"] != null ? "alerts = alerts(detector_id='${var.detectors["custom_metrics_ratio"]["id"]}').publish(label='alerts')" : ""}
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
    for_each = var.detectors["custom_metrics_ratio"] != null ? compact([var.detectors["custom_metrics_ratio"]["name"]]) : []
    content {
      display_name = var.detectors["custom_metrics_ratio"]["name"]
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

resource "signalfx_dashboard" "usage" {
  charts_resolution = "default"
  dashboard_group   = var.dashboard_group
  name              = var.name
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

  dynamic variable {
    for_each = var.is_parent ? compact([var.is_parent]) : []
    content {
      alias                  = "Child-org name"
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
}
