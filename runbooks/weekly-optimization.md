# Weekly Optimization Cycle

Run a weekly optimization cycle by combining landing page reports, experiment reports, channel breakdowns, and trend data.

## Goal

Identify what to scale, fix, pause, or test next based on UXON performance data.

## Command Sequence

### 1. Pull Landing Page Channel Reports

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

### 2. Pull Landing Page Trends

```json
{
  "command": "reports.landing_page.trends",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "granularity": "day"
  }
}
```

### 3. Pull Experiment Details

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

### 4. Pull Experiment Channel Reports

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

## Analysis Pattern

Summarize:

- Best-performing page or variant.
- Weakest channel or segment.
- Any experiment with enough signal to review.
- Any page with declining trend.
- Next recommended test or page change.

## Done Criteria

- Recommendations are tied to report data.
- High-impact changes are framed for operator approval.
- Follow-up tasks are specific enough to run next week.
