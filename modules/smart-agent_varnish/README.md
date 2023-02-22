# Varnish SignalFx dashboards

## Usage

Instantiate this module in your code:

```
module "signalfx-dashboards-smart-agent-varnish" {
  source = "github.com/claranet/terraform-signalfx-dashboards.git//modules/smart-agent_varnish"

  timerange = "-1h"
}
```
