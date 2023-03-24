resource "signalfx_dashboard_group" "varnish" {
  name        = "Varnish (Prometheus Exporter)"
  description = "Varnish (Prometheus Exporter) dashboards"
}

resource "signalfx_time_chart" "varnish_hit_rate" {
  name        = "Hit Rate"
  description = "Hit vs. Miss time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    A = data('varnish_main_cache_hit', filter=filter('system.type', 'prometheus-exporter'), rollup='delta').publish('hit')
    B = data('varnish_main_cache_miss', filter=filter('system.type', 'prometheus-exporter'), rollup='delta').publish('miss')
    signal = (A/(A+B)).fill(0).scale(100).publish('rate')
    EOF
}

resource "signalfx_single_value_chart" "varnish_hit_rate_last_minute" {
  name        = "Hit Rate (1 minute mean)"
  description = "Hit Rate (1 minute mean) time chart"

  secondary_visualization = "Radial"

  color_by = "Scale"

  color_scale {
      gt = 90
      lte = 100
      color = "green"
  }
  color_scale {
      gt = 80
      lte = 90
      color = "light_green"
  }
  color_scale {
      gt = 70
      lte = 80
      color = "yellow"
  }
  color_scale {
      gt = 50
      lte = 70
      color = "orange"
  }
  color_scale {
      gte = 0
      lte = 50
      color = "red"
  }

  program_text = <<-EOF
    A = data('varnish_main_cache_hit', filter=filter('system.type', 'prometheus-exporter'), rollup='delta').mean(over='1m')
    B = data('varnish_main_cache_miss', filter=filter('system.type', 'prometheus-exporter'), rollup='delta').mean(over='1m')
    signal = (A/(A+B)).fill(0).scale(100).publish('rate')
    EOF
}

resource "signalfx_single_value_chart" "varnish_hit_rate_last_hour" {
  name        = "Hit Rate (1 hour mean)"
  description = "Hit Rate (1 hour mean) time chart"

  secondary_visualization = "Radial"

  color_by = "Scale"

  color_scale {
      gt = 90
      lte = 100
      color = "green"
  }
  color_scale {
      gt = 80
      lte = 90
      color = "light_green"
  }
  color_scale {
      gt = 70
      lte = 80
      color = "yellow"
  }
  color_scale {
      gt = 50
      lte = 70
      color = "orange"
  }
  color_scale {
      gte = 0
      lte = 50
      color = "red"
  }

  program_text = <<-EOF
    A = data('varnish_main_cache_hit', filter=filter('system.type', 'prometheus-exporter'), rollup='delta').mean(over='60m')
    B = data('varnish_main_cache_miss', filter=filter('system.type', 'prometheus-exporter'), rollup='delta').mean(over='60m')
    signal = (A/(A+B)).fill(0).scale(100).publish('rate')
    EOF
}

resource "signalfx_time_chart" "varnish_memory_usage" {
  name        = "Memory usage"
  description = "Memory usage time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  viz_options {
      display_name = "bytes_outstanding"
      label = "bytes_outstanding"
      value_unit = "Byte"
  }
  viz_options {
      display_name = "bytes_available"
      label = "bytes_available"
      value_unit = "Byte"
  }
  viz_options {
      display_name = "signal"
      label = "signal"
  }

  program_text = <<-EOF
    # Display right units in the graph
    # https://docs.signalfx.com/en/latest/charts/chart-builder.html#display-units
    A = data('varnish_sma_g_bytes', filter=filter('system.type', 'prometheus-exporter') and filter('type', 's0')).publish('bytes_outstanding')
    B = data('varnish_sma_g_space', filter=filter('system.type', 'prometheus-exporter') and filter('type', 's0')).publish('bytes_available')
    signal = (A / (A+B)).scale(100).fill(0).publish('signal')
    EOF
}

resource "signalfx_single_value_chart" "varnish_memory_usage_last_minute" {
  name        = "Memory usage (1 minute mean)"
  description = "Memory usage (1 minute mean) time chart"

  secondary_visualization = "Radial"

  color_by = "Scale"

  color_scale {
      gt = 90
      lte = 100
      color = "red"
  }
  color_scale {
      gt = 80
      lte = 90
      color = "orange"
  }
  color_scale {
      gt = 70
      lte = 80
      color = "yellow"
  }
  color_scale {
      gte = 0
      lte = 70
      color = "green"
  }

  program_text = <<-EOF
    # Display right units in the graph
    # https://docs.signalfx.com/en/latest/charts/chart-builder.html#display-units
    A = data('varnish_sma_g_bytes', filter=filter('system.type', 'prometheus-exporter') and filter('type', 's0')).mean(over='1m')
    B = data('varnish_sma_g_space', filter=filter('system.type', 'prometheus-exporter') and filter('type', 's0')).mean(over='1m')
    signal = (A / (A+B)).scale(100).fill(0).publish('signal')
    EOF
}

resource "signalfx_time_chart" "varnish_thread_number" {
  name        = "Thread number"
  description = "Thread number time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('varnish_main_threads', filter=filter('system.type', 'prometheus-exporter')).publish('threads')
    EOF
}

resource "signalfx_time_chart" "varnish_thread_queue_len" {
  name        = "Thread queue len"
  description = "Thread queue len time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('varnish_main_thread_queue_len', filter=filter('system.type', 'prometheus-exporter')).publish('thread_queue_len')
    EOF
}

resource "signalfx_time_chart" "varnish_backend_unhealthy" {
  name        = "Backend unhealthy"
  description = "Backend unhealthy time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('varnish_backend_unhealthy', filter=filter('system.type', 'prometheus-exporter')).publish(label='backend_unhealthy')
    EOF
}

resource "signalfx_time_chart" "varnish_backend_fail" {
  name        = "Backend fail"
  description = "Backend fail time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('varnish_backend_fail', filter=filter('system.type', 'prometheus-exporter')).publish(label='backend_fail')
    EOF
}

resource "signalfx_time_chart" "varnish_client_req" {
  name        = "Client req"
  description = "Client req time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('varnish_main_client_req', filter=filter('system.type', 'prometheus-exporter')).publish(label='client_req')
    EOF
}

resource "signalfx_time_chart" "varnish_sessions_by_type" {
  name        = "Sessions by type"
  description = "Sessions by type time chart"

  time_range = 3600

  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('varnish_main_sessions', filter=filter('system.type', 'prometheus-exporter')).sum(by=['type']).publish()
    EOF
}

resource "signalfx_dashboard" "varnish" {
  charts_resolution = "high"
  dashboard_group   = signalfx_dashboard_group.varnish.id
  name              = "Varnish"
  time_range        = var.timerange

  chart {
    chart_id = signalfx_time_chart.varnish_hit_rate.id
    column   = 0
    row      = 0
    height   = 1
    width    = 6
  }
  chart {
    chart_id = signalfx_single_value_chart.varnish_hit_rate_last_minute.id
    column   = 6
    row      = 0
    height   = 1
    width    = 3
  }
  chart {
    chart_id = signalfx_single_value_chart.varnish_hit_rate_last_hour.id
    column   = 9
    row      = 0
    height   = 1
    width    = 3
  }

  chart {
    chart_id = signalfx_time_chart.varnish_memory_usage.id
    column   = 0
    row      = 1
    height   = 1
    width    = 6
  }
  chart {
    chart_id = signalfx_single_value_chart.varnish_memory_usage_last_minute.id
    column   = 6
    row      = 1
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.varnish_thread_number.id
    column   = 0
    row      = 2
    height   = 1
    width    = 6
  }
  chart {
    chart_id = signalfx_time_chart.varnish_thread_queue_len.id
    column   = 6
    row      = 2
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.varnish_backend_unhealthy.id
    column   = 0
    row      = 3
    height   = 1
    width    = 6
  }
  chart {
    chart_id = signalfx_time_chart.varnish_backend_fail.id
    column   = 6
    row      = 3
    height   = 1
    width    = 6
  }

  chart {
    chart_id = signalfx_time_chart.varnish_client_req.id
    column   = 0
    row      = 4
    height   = 1
    width    = 6
  }
  chart {
    chart_id = signalfx_time_chart.varnish_sessions_by_type.id
    column   = 6
    row      = 4
    height   = 1
    width    = 6
  }
}
