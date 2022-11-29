resource "signalfx_dashboard_group" "nginx_ingress" {
  name        = "Nginx ingress"
  description = "Nginx ingress controller dashboards"
}

resource "signalfx_time_chart" "nginx_ingress_current_requests" {
  name        = "Current requests"
  description = "Current requests time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('nginx_ingress_controller_requests').sum(by=['controller_class', 'controller_namespace', 'ingress']).publish()
    EOF

}

resource "signalfx_time_chart" "nginx_ingress_current_request_rate" {
  name        = "Current request rate (rqps)"
  description = "Current request rate time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('nginx_ingress_controller_requests', rollup='rate', extrapolation='zero').sum(by=['controller_class', 'controller_namespace', 'ingress']).publish()
    EOF

}

resource "signalfx_time_chart" "nginx_ingress_http_errors_4xx_ratio" {
  name        = "HTTP Errors 4xx ratio"
  description = "HTTP Errors 4xx ratio time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    A = data('nginx_ingress_controller_requests', filter=filter('status', '4*') and filter('sfx_monitored', 'true'), rollup='delta', extrapolation='zero').sum(by=['controller_namespace', 'controller_class', 'ingress'])
    B = data('nginx_ingress_controller_requests', filter('sfx_monitored', 'true'), rollup='delta', extrapolation='zero').sum(by=['controller_namespace', 'controller_class', 'ingress'])
    ratio_40X = (A/B).scale(100).fill(value=0).publish('ratio_40X')
    EOF

}

resource "signalfx_time_chart" "nginx_ingress_http_errors_5xx_ratio" {
  name        = "HTTP Errors 5xx ratio"
  description = "HTTP Errors 5xx ratio time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    A = data('nginx_ingress_controller_requests', filter=filter('status', '5*') and filter('sfx_monitored', 'true'), rollup='delta', extrapolation='zero').sum(by=['controller_namespace', 'controller_class', 'ingress'])
    B = data('nginx_ingress_controller_requests', filter('sfx_monitored', 'true'), rollup='delta', extrapolation='zero').sum(by=['controller_namespace', 'controller_class', 'ingress'])
    ratio_50X = (A/B).scale(100).fill(value=0).publish('ratio_50X')
    EOF

}

resource "signalfx_time_chart" "nginx_ingress_upstream_service_latency_per_ingress" {
  name        = "Upstream service latency per Ingress"
  description = "Upstream service latency per Ingress time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('nginx_ingress_controller_ingress_upstream_latency_seconds', rollup='delta').sum(by=['controller_class', 'controller_namespace', 'ingress']).publish()
    EOF

}

resource "signalfx_time_chart" "nginx_ingress_current_process_cpu_seconds" {
  name        = "Current process cpu seconds"
  description = "Current process cpu seconds time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('nginx_ingress_controller_nginx_process_cpu_seconds_total').sum(by=['controller_class', 'controller_namespace']).publish()
    EOF

}

resource "signalfx_time_chart" "nginx_ingress_process_resident_memory_bytes" {
  name        = "Process resident memory bytes"
  description = "Process resident memory bytes time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('nginx_ingress_controller_nginx_process_resident_memory_bytes').sum(by=['controller_class', 'controller_namespace']).publish()
    EOF

}

resource "signalfx_time_chart" "nginx_ingress_process_virtual_memory_bytes" {
  name        = "Process resident virtual bytes"
  description = "Process resident virtual bytes time chart"

  time_range = 3600

  on_chart_legend_dimension = "ingress"
  color_by                  = "Dimension"
  plot_type                 = "LineChart"

  program_text = <<-EOF
    data('nginx_ingress_controller_nginx_process_virtual_memory_bytes').sum(by=['controller_class', 'controller_namespace']).publish()
    EOF

}

resource "signalfx_dashboard" "nginx_ingress" {
  charts_resolution = "high"
  dashboard_group   = signalfx_dashboard_group.nginx_ingress.id
  name              = "Nginx Ingress Controller"
  time_range        = var.timerange

  chart {
    chart_id = signalfx_time_chart.nginx_ingress_current_requests.id
    column   = 0
    height   = 1
    width    = 6
    row      = 0
  }
  chart {
    chart_id = signalfx_time_chart.nginx_ingress_current_request_rate.id
    column   = 6
    height   = 1
    width    = 6
    row      = 0
  }

  chart {
    chart_id = signalfx_time_chart.nginx_ingress_http_errors_4xx_ratio.id
    column   = 0
    height   = 1
    width    = 6
    row      = 1
  }
  chart {
    chart_id = signalfx_time_chart.nginx_ingress_http_errors_5xx_ratio.id
    column   = 6
    height   = 1
    width    = 6
    row      = 1
  }

  chart {
    chart_id = signalfx_time_chart.nginx_ingress_upstream_service_latency_per_ingress.id
    column   = 0
    height   = 1
    width    = 6
    row      = 2
  }
  chart {
    chart_id = signalfx_time_chart.nginx_ingress_current_process_cpu_seconds.id
    column   = 6
    height   = 1
    width    = 6
    row      = 2
  }

  chart {
    chart_id = signalfx_time_chart.nginx_ingress_process_resident_memory_bytes.id
    column   = 0
    height   = 1
    width    = 6
    row      = 3
  }
  chart {
    chart_id = signalfx_time_chart.nginx_ingress_process_virtual_memory_bytes.id
    column   = 6
    height   = 1
    width    = 6
    row      = 3
  }
}
