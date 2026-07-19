# Launch An A/B Test With UXON Pages

Launch an A/B test between UXON landing page variants by resolving goals, pages, variants, then creating and starting an experiment.

## Inputs To Collect

- `siteId`
- Primary conversion goal
- Control landing page and variant
- Variant landing page and variant
- Experiment nickname
- Traffic allocation
- Visitor or device filters, if needed
- Optional traffic filters, such as `utm_source = google`
- Optional geo filters

## Command Sequence

### 1. Resolve Goals

```json
{
  "command": "goals.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

### 2. Resolve Landing Pages

```json
{
  "command": "landing_pages.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

### 3. Resolve Variant IDs

```json
{
  "command": "reports.landing_page.details",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

### 4. Create The Draft Experiment

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

### 5. Start The Experiment

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

### 6. Monitor Results

Read back setup and status first:

```json
{
  "command": "experiments.get",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid"
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

## Done Criteria

- Experiment exists in UXON.
- Experiment status is `Running`.
- Selected goals are attached.
- First reporting check is scheduled.
