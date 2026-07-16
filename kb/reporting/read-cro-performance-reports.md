# Read CRO Performance Reports From An Agent

UXON reporting commands let an agent summarize landing page performance, experiment results, channel attribution, trends, contacts, and revenue where configured. A good reporting workflow starts with summary commands, drills into page or experiment details, then checks channel-level performance before recommending the next action.

## Recommended Report Flow

1. Run `subaccounts.list` to find available client accounts.
2. Run `landing_pages.list` and `experiments.list` for each relevant site.
3. Run summary reports to understand account-level activity.
4. Run detail reports for the page or experiment under review.
5. Run channel reports to find source-specific changes.

## Useful Commands

```json
{
  "command": "reports.landing_pages.summary",
  "input": {
    "siteId": "site_uuid"
  }
}
```

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

```json
{
  "command": "reports.experiment.channels",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "dateRange": "last-30-days",
    "conversionGoalId": "all"
  }
}
```

## Agent Output Pattern

The agent should report:

- What changed.
- Which page, experiment, variant, or channel is involved.
- Which metric supports the observation.
- Whether the data is directional or strong enough to act on.
- The next recommended check or action.

## Related Files

- [Reports API](../../skills/reports.md)
- [Morning account check](../../runbooks/morning-account-check.md)
- [Weekly optimization cycle](../../runbooks/weekly-optimization.md)
