resource "signalfx_dashboard_group" "nagios" {
  name        = "Nagios dashboard group"
  description = "Nagios like dashboards"

}

resource "signalfx_heatmap_chart" "nagiosheat" {
  name        = "Nagios check - HeatMap"
  description = "Nagios like heatMap"

  program_text = <<-EOF
    data("nagios.state").publish()
    EOF

  # UNKNOWN
  color_scale {
    gte   = 3
    color = "gray"
  }
  # CRITICAL
  color_scale {
    gte   = 2
    lt    = 3
    color = "red"
  }
  # WARNING
  color_scale {
    gte   = 1
    lt    = 2
    color = "yellow"
  }
  # OK
  color_scale {
    lt    = 1
    color = "green"
  }
  max_delay        = 0
  disable_sampling = true
  refresh_interval = 30

}

resource "signalfx_list_chart" "nagioslist" {
  name        = "Nagios check - List"
  description = "Nagios like list chart"

  program_text = <<-EOF
    data("nagios.state").publish()
    EOF

  color_by = "Scale"
  # UNKNOWN
  color_scale {
    gte   = 3
    color = "gray"
  }
  # CRITICAL
  color_scale {
    gte   = 2
    lt    = 3
    color = "red"
  }
  # WARNING
  color_scale {
    gte   = 1
    lt    = 2
    color = "yellow"
  }
  # OK
  color_scale {
    lt    = 1
    color = "green"
  }
  max_delay        = 0
  disable_sampling = true
  refresh_interval = 30

  legend_options_fields {
    property = "documentation"
    enabled  = false
  }

  legend_options_fields {
    property = "sf_originatingMetric"
    enabled  = false
  }

  legend_options_fields {
    property = "sf_metric"
    enabled  = false
  }
  legend_options_fields {
    property = "plugin"
    enabled  = false
  }
  legend_options_fields {
    property = "command"
    enabled  = false
  }
  legend_options_fields {
    property = "sfx_monitored"
    enabled  = false
  }
  max_precision = 2
  sort_by       = "-value"
}

resource "signalfx_time_chart" "nagiostime" {
  name        = "Nagios check - Time chart"
  description = "Nagios like time chart"

  program_text = <<-EOF
    data("nagios.state").publish()
    EOF

  time_range = 3600

  on_chart_legend_dimension = "service"
  plot_type                 = "LineChart"
  legend_options_fields {
    property = "metric"
    enabled  = false
  }

  legend_options_fields {
    property = "sfx_monitored"
    enabled  = false
  }
  legend_options_fields {
    property = "documentation"
    enabled  = false
  }

  legend_options_fields {
    property = "sf_originatingMetric"
    enabled  = false
  }

  legend_options_fields {
    property = "sf_metric"
    enabled  = false
  }
  legend_options_fields {
    property = "plugin"
    enabled  = false
  }
  legend_options_fields {
    property = "command"
    enabled  = false
  }
  legend_options_fields {
    property = "env"
    enabled  = false
  }

}

resource "signalfx_event_feed_chart" "nagiosevent" {
  name         = "Nagios Event on hosts"
  description  = "Nagios event pushed by host"
  program_text = "A = events(eventType='${var.eventtype}').publish(label='A')"
}

resource "signalfx_dashboard" "nagios" {
  charts_resolution = "high"
  dashboard_group   = signalfx_dashboard_group.nagios.id
  name              = "Nagios"
  time_range        = var.timerange
  selected_event_overlay {
    signal = var.eventtype
  }
  event_overlay {
    line   = true
    color  = "orange"
    signal = var.eventtype
  }

  chart {
    chart_id = signalfx_list_chart.nagioslist.id
    column   = 0
    height   = 5
    width    = 6
    row      = 1
  }
  chart {
    chart_id = signalfx_event_feed_chart.nagiosevent.id
    column   = 0
    height   = 2
    width    = 6
    row      = 2
  }
  chart {
    chart_id = signalfx_time_chart.nagiostime.id
    column   = 7
    height   = 1
    width    = 6
    row      = 1
  }
  chart {
    chart_id = signalfx_heatmap_chart.nagiosheat.id
    column   = 7
    height   = 4
    width    = 6
    row      = 2
  }
}
