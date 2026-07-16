# Run A Cross-Domain A/B Experiment

Run a cross-domain A/B experiment by comparing UXON pages, existing website pages, product pages, checkout pages, or other external URLs inside one UXON experiment.

## Inputs To Collect

- `siteId`
- Primary conversion goal
- Control URL
- Variant URL
- Experiment nickname
- Whether query parameters should be preserved

## Command Sequence

### 1. Confirm Goal

```json
{
  "command": "goals.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

### 2. Create The Draft Experiment

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

### 3. Start The Experiment

Confirm launch with the operator first.

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

### 4. Monitor Channel Results

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

## Done Criteria

- External control and variant URLs are valid.
- Experiment exists as a UXON draft before launch.
- Operator confirmed launch.
- Experiment is running.
- Reporting command is ready for follow-up.
