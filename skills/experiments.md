# A/B Testing And Experiments API

Run A/B tests across UXON-hosted pages, external URLs, or URL-pattern targets. The experiments API handles draft creation, variant source selection, traffic settings, lifecycle status, and reporting by channel, goal, and revenue where configured.

## Core Commands

- `experiments.list`: list experiments for one sub-account.
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
    "variantVariant": "lpv_variant_uuid"
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
- Resolve landing page variant IDs with `reports.landing_page.details`.
- Do not combine the Bounce goal with other goals.
- URL patterns can be used on control or variant, not both.
- Confirm before setting an experiment to `Running`.

## Related Files

- [Goals](goals.md)
- [Reports](reports.md)
- [Launch experiment example](../examples/curl/launch-experiment.sh)
- [Cross-domain experiment runbook](../runbooks/cross-domain-experiment.md)
