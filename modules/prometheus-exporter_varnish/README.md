# Prometheus Exporter for Varnish

## Usage

Instantiate this module in your code:

```
module "signalfx-dashboards-prometheus-exporter-varnish" {
  source = "github.com/claranet/terraform-signalfx-dashboards.git//modules/prometheus-exporter_varnish"

  timerange = "-1h"
}
```
