# CRO Reports API

Pull CRO performance data from any agent or automation. UXON reports cover landing page summaries, experiment results, variant metrics, channel attribution, trends, contacts, and revenue where configured.

## Landing Page Reports

- `reports.landing_pages.summary`: aggregate landing page totals.
- `reports.landing_page.details`: detailed landing page record and variants.
- `reports.landing_page.variant_metrics`: variant-level metrics.
- `reports.landing_page.trends`: time-series landing page metrics.
- `reports.landing_page.channels`: channel attribution view for one landing page.

## Experiment Reports

- `reports.experiments.summary`: aggregate experiment totals.
- `reports.experiment.details`: experiment analytics and decision context.
- `reports.experiment.chart`: chart-ready time series.
- `reports.experiment.channels`: channel-level split by control and variant.

## Contact Reports

- `reports.contacts.list`: list contacts with filters and pagination.
- `reports.contacts.detail`: fetch one contact profile and latest submission detail.

## Date Range And Timezone

Report commands default to the last 30 days when no date range is provided.

Supported `dateRange` presets:

- `today`
- `yesterday`
- `last-3-days`
- `last-7-days`
- `last-14-days`
- `last-30-days`
- `last-90-days`
- `last-365-days`
- `custom`

For custom windows, send `dateRange: "custom"` with `from` and `to` as ISO-8601 strings.

`timezone` should be a valid IANA timezone, such as `UTC`, `Australia/Brisbane`, `America/New_York`, or `Europe/London`. If omitted, UXON uses the sub-account reporting timezone, then `UTC`.

## Example: Experiment Details

```json
{
  "command": "reports.experiment.details",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "conversionGoalId": "all",
    "dateRange": "last-30-days",
    "timezone": "Australia/Brisbane"
  }
}
```

## Example: Landing Page Channels

```json
{
  "command": "reports.landing_page.channels",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "dateRange": "last-30-days"
  }
}
```

## Agent Reporting Pattern

1. Resolve the `siteId`.
2. Pull summary reports for the account.
3. Pull details for the page or experiment under review.
4. Pull channel reports to find source-specific differences.
5. Summarize what changed, what is trustworthy, and what should be checked next.

## Related Files

- [Morning account check](../runbooks/morning-account-check.md)
- [Weekly optimization](../runbooks/weekly-optimization.md)
- [Pull report example](../examples/curl/pull-report.sh)
