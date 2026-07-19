# A/B Testing And Experiments API

Run A/B tests across UXON-hosted pages, external URLs, or URL-pattern targets. The experiments API handles draft creation, source selection, selected goals, traffic allocation, visitor/device targeting, traffic filters, geo filters, lifecycle status, and reporting.

## Core Commands

- `experiments.list`: list experiments for one sub-account.
- `experiments.get`: get one experiment's setup, status, selected goals, targeting, and saved counters.
- `experiments.create`: create a draft experiment.
- `experiments.update`: update mutable experiment settings.
- `experiments.set_status`: move an experiment to `Draft`, `Running`, `Paused`, or `Ended`.
- `reports.experiment.details`: read experiment decision context.
- `reports.experiment.chart`: read chart-ready experiment time series.
- `reports.experiment.channels`: read channel-segmented experiment performance.

## Experiment Sources

UXON supports three experiment source patterns:

- `uxon`: use UXON landing page and variant IDs.
- `external`: use external page URLs.
- `url_patterns`: use URL matching rules for one side of the experiment.

## Targeting Fields

- `testTrigger`: `entry` or `visits`.
- `visitorType`: `all-visitors`, `new-visitors`, or `returning-visitors`.
- `deviceType`: `all-devices`, `desktop-only`, or `mobile-only`.
- `trafficAllocation`: number from `0` to `100`.
- `preserveRedirectParams`: default `true`.
- `urlPatterns.conditions[].operator`: `is`, `contains`, `starts_with`, or `ends_with`.
- `urlPatterns` supports up to 5 total conditions and can be used on Control or Variant, not both.
- `geoFilters.countries.type`: `include` or `exclude`.

## Traffic Filters

`trafficFilters` are exact string key/value tracking filters:

```json
{
  "utm_source": "google",
  "utm_medium": "cpc",
  "utm_campaign": "winter-sale"
}
```

Do not use regex, operators, arrays, includes/contains matching, or country filters. Use `geoFilters` for country targeting.

## Create A UXON Page Experiment

```json
{
  "command": "experiments.create",
  "input": {
    "siteId": "site_uuid",
    "nickname": "Headline Test",
    "selectedGoals": [
      { "id": "lead_goal_uuid", "name": "Lead" }
    ],
    "controlSource": "uxon",
    "controlLandingPage": "lp_control_uuid",
    "controlVariant": "lpv_control_uuid",
    "variantSource": "uxon",
    "variantLandingPage": "lp_variant_uuid",
    "variantVariant": "lpv_variant_uuid",
    "testTrigger": "entry",
    "visitorType": "all-visitors",
    "deviceType": "all-devices",
    "trafficAllocation": 100
  }
}
```

## Create A Cross-Domain Experiment

```json
{
  "command": "experiments.create",
  "input": {
    "siteId": "site_uuid",
    "nickname": "Checkout Hero Test",
    "selectedGoals": [
      { "id": "lead_goal_uuid", "name": "Lead" }
    ],
    "controlSource": "external",
    "controlPageUrl": "https://www.example.com/checkout-a",
    "variantSource": "external",
    "variantPageUrl": "https://www.example.com/checkout-b",
    "preserveRedirectParams": true
  }
}
```

## Create A URL Pattern Experiment

```json
{
  "command": "experiments.create",
  "input": {
    "siteId": "site_uuid",
    "nickname": "Pricing Redirect Test",
    "selectedGoals": [
      { "id": "lead_goal_uuid", "name": "Lead" }
    ],
    "controlSource": "url_patterns",
    "variantSource": "external",
    "variantPageUrl": "https://www.example.com/pricing-variant",
    "urlPatterns": {
      "side": "control",
      "conditions": [
        { "type": "include", "operator": "contains", "value": "/pricing" }
      ]
    }
  }
}
```

## Update Targeting

```json
{
  "command": "experiments.update",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "trafficAllocation": 75,
    "testTrigger": "visits",
    "visitorType": "new-visitors",
    "deviceType": "desktop-only",
    "trafficFilters": {
      "utm_source": "google",
      "utm_campaign": "brand"
    },
    "geoFilters": {
      "countries": {
        "type": "exclude",
        "countryCodes": ["GB"],
        "includeUnknown": true
      }
    }
  }
}
```

## Launch An Experiment

`experiments.create` creates a draft. Use `experiments.set_status` to launch after confirmation.

```json
{
  "command": "experiments.set_status",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "status": "Running"
  }
}
```

## Guardrails

- Use `selectedGoals` for new integrations.
- Resolve landing page variant IDs with `landing_pages.get` or `reports.landing_page.details`.
- Do not combine the Bounce goal with other goals.
- URL patterns can be used on control or variant, not both.
- Confirm before setting an experiment to `Running`.

## Related Files

- [Goals](goals.md)
- [Reports](reports.md)
- [Launch experiment example](../examples/curl/launch-experiment.sh)
- [Cross-domain experiment runbook](../runbooks/cross-domain-experiment.md)
