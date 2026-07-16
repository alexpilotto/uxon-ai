# Morning Account Check

Run a morning account check to summarize what is live, what is running, and which landing pages or experiments need attention.

## Goal

Produce a short per-client summary covering live pages, running experiments, sessions, conversions, and obvious follow-up actions.

## Command Sequence

### 1. List Sub-Accounts

```json
{
  "command": "subaccounts.list",
  "input": {}
}
```

### 2. List Pages And Experiments Per Site

```json
{
  "command": "landing_pages.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

```json
{
  "command": "experiments.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

### 3. Pull Summary Reports

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
  "command": "reports.experiments.summary",
  "input": {
    "siteId": "site_uuid"
  }
}
```

## Output Format

For each client:

- Live landing pages
- Draft landing pages
- Running experiments
- Sessions
- Conversions
- Revenue, if configured
- One recommended next check

## Done Criteria

- Every accessible sub-account has a summary.
- Any missing tracking, stalled launches, or underperforming experiments are flagged.
- No write commands are run during this read-only check.
