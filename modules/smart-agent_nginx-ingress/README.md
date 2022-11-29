# Nginx Ingress SignalFx dashboards

## Usage

Instantiate this module in your code:

```
module "signalfx-dashboards-smart-agent-nginx-ingress" {
  source = "github.com/claranet/terraform-signalfx-dashboards.git//modules/smart-agent_nginx-ingress"

  timerange = "-1h"
}
```
