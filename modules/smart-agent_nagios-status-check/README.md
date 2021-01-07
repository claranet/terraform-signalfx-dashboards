# Nagios dashboard

![](././img/nagios_dashboard.png)

## Nagios like dashboard

This dashboard works with [Nagios](https://docs.signalfx.com/en/latest/integrations/agent/monitors/nagios.html) monitors.  

Exemple of monitors

```
  - type: nagios
  intervalSeconds: 180
  command: /usr/lib/nagios/plugins/check_http -I google.fr -f sticky -H google.fr -s http -u / -p 80
  service: HTT_google
  extraDimensions:
    sfx_monitored: true
```

You may not want all "Nagios like" monitors to have a detectors associated with it.  
This can also help you migrate from a "Nagios like" system to SignalFX

## Usage

To use this module you can use the following

```
module "signalfx-dashboards-nagios" {
  source = "github.com/claranet/terraform-signalfx-dashboards.git//nagios"

  timerange = "-4h"
}
```
