# UXON Quickstart For AI Agents

UXON gives AI agents and developers a controlled way to create landing pages, launch A/B tests, configure tracking, and pull CRO reports.

Use this quickstart to connect through the API command endpoint or the Claude MCP connector.

## Option 1: API Key Commands

Use API keys when building custom agents, scheduled jobs, Slack bots, or internal automation.

### 1. Create An API Key

In UXON, create an API key from account settings. API keys use the `uxon_live_` prefix.

Keep the key secret. Do not commit it to GitHub.

### 2. Send A Health-Style Read Command

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command": "subaccounts.list",
    "input": {}
  }'
```

If the key is valid, UXON returns the sub-accounts available to that key.

### 3. Create A Landing Page Draft

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command": "landing_pages.create",
    "input": {
      "siteId": "site_uuid",
      "name": "Spring Offer"
    }
  }'
```

### 4. Create A Draft Experiment

Resolve landing page and variant IDs first with `landing_pages.list` and `reports.landing_page.details`.

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
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
  }'
```

### 5. Pull A Report

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command": "reports.experiment.details",
    "input": {
      "siteId": "site_uuid",
      "experimentId": "exp_uuid",
      "conversionGoalId": "all"
    }
  }'
```

## Option 2: Claude MCP Connector

Use the Claude connector when a teammate wants chat-native UXON workflows with OAuth authentication.

MCP endpoint:

```text
https://uxon.ai/api/mcp
```

After connecting, try:

```text
Show my client accounts in UXON.
```

Then start a guided setup workflow:

```text
Start first client setup for Acme Dental, website https://acmedental.com.
```

Claude will ask for missing inputs and call UXON tools behind the scenes.

## Recommended Agent Rules

- Resolve IDs before writes.
- Confirm before publishing pages or starting experiments.
- Confirm before changing tracking or domains.
- Use `selectedGoals` for new experiments.
- Read back resources after write commands.
- Pull reports after traffic starts.

## Next Files

- [SKILLS.md](SKILLS.md) for the command catalogue.
- [docs/what-is-uxon.md](docs/what-is-uxon.md) for the platform overview.
- [docs/faq.md](docs/faq.md) for capability-focused questions.
