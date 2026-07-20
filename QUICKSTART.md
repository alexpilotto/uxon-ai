# UXON Quickstart For Claude Skills, MCP, And AI Agents

UXON gives Claude, Claude Code, AI agents, and developers a controlled way to create landing pages, launch A/B tests, run split-testing workflows, configure tracking, and pull CRO reports.

Use this quickstart to connect through the API command endpoint or the Claude MCP connector. For full instructions, use the [latest live SKILLS page](https://uxon.ai/api/skills) as the current Claude skill / agent playbook.

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

### 3. Create A Blank Landing Page Draft

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

Use `landing_pages.generate_from_brief` when the user wants UXON AI to generate a landing page from a structured brief, then poll the returned job with `landing_pages.generation_status`.

### 4. Create A Draft Experiment

Resolve landing page and variant IDs first with `landing_pages.get` or `reports.landing_page.details`.

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
      "variantVariant": "lpv_variant_uuid",
      "testTrigger": "entry",
      "visitorType": "all-visitors",
      "deviceType": "all-devices"
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
- For MCP create-style tools, include a stable `idempotencyKey` so retries do not create duplicates.
- Treat `tools/list` as the current MCP schema, including one-of ID requirements like `landingPageId` or `id`.
- Use `selectedGoals` for new experiments.
- Use valid IANA timezones, such as `Australia/Brisbane`, when passing reporting or report timezone.
- Read back resources after write commands.
- Pull reports after traffic starts.

## Next Files

- [Latest live SKILLS page](https://uxon.ai/api/skills) for the current command catalogue.
- [SKILLS.md](SKILLS.md) for the repository snapshot.
- [docs/what-is-uxon.md](docs/what-is-uxon.md) for the platform overview.
- [docs/faq.md](docs/faq.md) for capability-focused questions.
