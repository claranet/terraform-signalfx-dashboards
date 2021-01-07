# signalfx_list_chart.usage-mts_0:
resource "signalfx_list_chart" "usage-mts_0" {
  color_by                = "Metric"
  disable_sampling        = false
  hide_missing_values     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Licences"
  program_text            = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A')
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B')
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C')
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D')
        E = (A+B+C+D).publish(label='E')
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F')
        G = (F-(E*${var.licence_pool})).publish(label='G')
        H = (G/${var.licence_pool}).publish(label='H')
        I = (E+H).publish(label='I')
        J = (I*${var.licence_price}).publish(label='J', enable=False)
        K = (F-G).publish(label='K')
        L = (G/F).scale(100).publish(label='L')
        M = (H/I).scale(100).publish(label='M')
        N = (F/E).publish(label='N')
    EOF
  secondary_visualization = "Sparkline"
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

  viz_options {
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
    value_suffix = "%"
  }
}
# signalfx_single_value_chart.usage-mts_1:
resource "signalfx_single_value_chart" "usage-mts_1" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Estimated Price"
  program_text            = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A', enable=False)
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B', enable=False)
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C', enable=False)
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D', enable=False)
        E = (A+B+C+D).publish(label='E', enable=False)
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F', enable=False)
        G = (F-(E*${var.licence_pool})).publish(label='G', enable=False)
        H = (G/${var.licence_pool}).publish(label='H', enable=False)
        I = (E+H).publish(label='I', enable=False)
        J = (I*${var.licence_price}).publish(label='J')
        K = (F-G).publish(label='K', enable=False)
        L = (G/F).scale(100).publish(label='L', enable=False)
        M = (H/I).scale(100).publish(label='M', enable=False)
        N = (F/E).publish(label='N', enable=False)
    EOF
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
    value_suffix = "%"
  }
}
# signalfx_single_value_chart.usage-mts_2:
resource "signalfx_single_value_chart" "usage-mts_2" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "Licences total"
  program_text            = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A', enable=False)
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B', enable=False)
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C', enable=False)
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D', enable=False)
        E = (A+B+C+D).publish(label='E', enable=False)
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F', enable=False)
        G = (F-(E*${var.licence_pool})).publish(label='G', enable=False)
        H = (G/${var.licence_pool}).publish(label='H', enable=False)
        I = (E+H).publish(label='I')
        J = (I*${var.licence_price}).publish(label='J', enable=False)
        K = (F-G).publish(label='K', enable=False)
        L = (G/F).scale(100).publish(label='L', enable=False)
        M = (H/I).scale(100).publish(label='M', enable=False)
        N = (F/E).publish(label='N', enable=False)
    EOF
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
    value_suffix = "%"
  }
}
# signalfx_single_value_chart.usage-mts_3:
resource "signalfx_single_value_chart" "usage-mts_3" {
  color_by                = "Metric"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 0
  name                    = "MTS total"
  program_text            = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A', enable=False)
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B', enable=False)
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C', enable=False)
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D', enable=False)
        E = (A+B+C+D).publish(label='E', enable=False)
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F', enable=False)
        G = (F-(E*${var.licence_pool})).publish(label='G')
        H = (G/${var.licence_pool}).publish(label='H', enable=False)
        I = (E+H).publish(label='I', enable=False)
        J = (I*${var.licence_price}).publish(label='J', enable=False)
        K = (F-G).publish(label='K', enable=False)
        L = (G/F).scale(100).publish(label='L', enable=False)
        M = (H/I).scale(100).publish(label='M', enable=False)
        N = (F/E).publish(label='N', enable=False)
    EOF
  secondary_visualization = "None"
  show_spark_line         = false
  unit_prefix             = "Metric"

  viz_options {
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
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
  plot_type                 = "AreaChart"
  program_text              = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A', enable=False)
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B', enable=False)
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C', enable=False)
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D', enable=False)
        E = (A+B+C+D).publish(label='E')
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F', enable=False)
        G = (F-(E*${var.licence_pool})).publish(label='G', enable=False)
        H = (G/${var.licence_pool}).publish(label='H')
        I = (E+H).publish(label='I', enable=False)
        J = (I*${var.licence_price}).publish(label='J', enable=False)
        K = (F-G).publish(label='K', enable=False)
        L = (G/F).scale(100).publish(label='L', enable=False)
        M = (H/I).scale(100).publish(label='M', enable=False)
        N = (F/E).publish(label='N', enable=False)
    EOF
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = true
  time_range                = 2678400
  unit_prefix               = "Metric"

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
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    axis         = "left"
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    axis         = "left"
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    axis         = "left"
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
    value_suffix = "%"
  }
}
# signalfx_single_value_chart.usage-mts_5:
resource "signalfx_single_value_chart" "usage-mts_5" {
  color_by                = "Scale"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 4
  name                    = "Average MTS per Host"
  program_text            = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A', enable=False)
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B', enable=False)
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C', enable=False)
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D', enable=False)
        E = (A+B+C+D).publish(label='E', enable=False)
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F', enable=False)
        G = (F-(E*${var.licence_pool})).publish(label='G', enable=False)
        H = (G/${var.licence_pool}).publish(label='H', enable=False)
        I = (E+H).publish(label='I', enable=False)
        J = (I*${var.licence_price}).publish(label='J', enable=False)
        K = (F-G).publish(label='K', enable=False)
        L = (G/F).scale(100).publish(label='L', enable=False)
        M = (H/I).scale(100).publish(label='M', enable=False)
        N = (F/E).publish(label='N')
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
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
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
  plot_type                 = "AreaChart"
  program_text              = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A', enable=False)
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B', enable=False)
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C', enable=False)
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D', enable=False)
        E = (A+B+C+D).publish(label='E', enable=False)
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F', enable=False)
        G = (F-(E*${var.licence_pool})).publish(label='G')
        H = (G/${var.licence_pool}).publish(label='H', enable=False)
        I = (E+H).publish(label='I', enable=False)
        J = (I*${var.licence_price}).publish(label='J', enable=False)
        K = (F-G).publish(label='K')
        L = (G/F).scale(100).publish(label='L', enable=False)
        M = (H/I).scale(100).publish(label='M', enable=False)
        N = (F/E).publish(label='N', enable=False)
    EOF
  show_data_markers         = false
  show_event_lines          = false
  stacked                   = true
  time_range                = 2678400
  unit_prefix               = "Metric"

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
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    axis         = "left"
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    axis         = "left"
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    axis         = "left"
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    axis         = "left"
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    axis         = "left"
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    axis         = "left"
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    axis         = "left"
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    axis         = "left"
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    axis         = "left"
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    axis         = "left"
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    axis         = "left"
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    axis         = "left"
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    axis         = "left"
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
    value_suffix = "%"
  }
}
# signalfx_single_value_chart.usage-mts_7:
resource "signalfx_single_value_chart" "usage-mts_7" {
  color_by                = "Scale"
  is_timestamp_hidden     = true
  max_delay               = 0
  max_precision           = 4
  name                    = "% of MTS burst"
  program_text            = <<-EOF
        A = data('cpu.utilization', filter=(not filter('aws_instance_id', '*')) and (not filter('gcp_id', '*')) and (not filter('azure_vm_id', '*'))).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='A', enable=False)
        B = data('CPUUtilization', filter=filter('namespace', 'AWS/EC2') and filter('stat', 'mean') and filter('aws_instance_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='B', enable=False)
        C = data('Percentage CPU', filter=filter('primary_aggregation_type', 'true') and filter('azure_vm_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='C', enable=False)
        D = data('instance/uptime', filter=filter('gcp_id', '*')).count().mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='D', enable=False)
        E = (A+B+C+D).publish(label='E', enable=False)
        F = data('sf.org.numCustomMetrics').mean(cycle='hour', cycle_start='0m', partial_values=True).mean(cycle='month', cycle_start='1d', partial_values=True).publish(label='F', enable=False)
        G = (F-(E*${var.licence_pool})).publish(label='G', enable=False)
        H = (G/${var.licence_pool}).publish(label='H', enable=False)
        I = (E+H).publish(label='I', enable=False)
        J = (I*${var.licence_price}).publish(label='J', enable=False)
        K = (F-G).publish(label='K', enable=False)
        L = (G/F).scale(100).publish(label='L')
        M = (H/I).scale(100).publish(label='M', enable=False)
        N = (F/E).publish(label='N', enable=False)
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
    display_name = "Hosts from AWS"
    label        = "B"
  }
  viz_options {
    display_name = "Hosts from Azure"
    label        = "C"
  }
  viz_options {
    display_name = "Hosts from GCP"
    label        = "D"
  }
  viz_options {
    display_name = "Hosts from agent only"
    label        = "A"
  }
  viz_options {
    color        = "aquamarine"
    display_name = "Estimated price"
    label        = "J"
    value_prefix = "$"
  }
  viz_options {
    color        = "brown"
    display_name = "MTS in Burst"
    label        = "G"
  }
  viz_options {
    color        = "emerald"
    display_name = "Average MTS per Host"
    label        = "N"
  }
  viz_options {
    color        = "gray"
    display_name = "MTS in Hosts"
    label        = "K"
  }
  viz_options {
    color        = "lilac"
    display_name = "Licenses total"
    label        = "I"
  }
  viz_options {
    color        = "magenta"
    display_name = "Licences in Burst"
    label        = "H"
  }
  viz_options {
    color        = "navy"
    display_name = "Licenses in Hosts"
    label        = "E"
  }
  viz_options {
    color        = "orange"
    display_name = "% of Licences burst"
    label        = "M"
    value_suffix = "%"
  }
  viz_options {
    color        = "purple"
    display_name = "MTS total"
    label        = "F"
  }
  viz_options {
    color        = "yellow"
    display_name = "% of MTS burst"
    label        = "L"
    value_suffix = "%"
  }
}
# signalfx_dashboard.usage-mts:
resource "signalfx_dashboard" "usage-mts" {
  charts_resolution = "default"
  dashboard_group   = signalfx_dashboard_group.usage-mts.id
  name              = "Usage"
  time_range        = "-31d"

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
