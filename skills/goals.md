# Conversion Goals API

Create and manage conversion goals that landing pages and experiments use for reporting and decision-making.

## Core Commands

- `goals.list`: list conversion goals for one sub-account.
- `goals.create`: create a custom conversion goal.
- `goals.update`: update goal metadata or activation status.

## List Goals

```json
{
  "command": "goals.list",
  "input": {
    "siteId": "site_uuid",
    "page": 1,
    "perPage": 25
  }
}
```

## Create A Goal

```json
{
  "command": "goals.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Qualified Lead",
    "isActive": true
  }
}
```

## Use Goals In Experiments

New integrations should use `selectedGoals` when creating experiments.

```json
{
  "selectedGoals": [
    { "id": "lead_goal_uuid", "name": "Qualified Lead" }
  ]
}
```

## Related Files

- [Experiments](experiments.md)
- [Reports](reports.md)
