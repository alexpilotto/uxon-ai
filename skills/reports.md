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

## Example: Experiment Details

```json
{
  "command": "reports.experiment.details",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "conversionGoalId": "all"
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
