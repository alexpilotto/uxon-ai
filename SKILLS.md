# UXON Agent Command Playbook

This playbook describes the public UXON API and MCP command surface for AI agents, automation tools, and developers.

Use this document when an external agent needs to create landing pages, import code variants, launch experiments, configure tracking, read CRO reports, or run repeatable agency workflows in UXON.

## Connection Options

UXON supports two agent connection paths:

- Claude connector over MCP for OAuth-based chat workflows.
- API key plus command envelope for custom agents, internal tools, Slack bots, scheduled jobs, and orchestration platforms.

MCP endpoint:

```text
https://uxon.ai/api/mcp
```

API command endpoint:

```text
POST https://uxon.ai/api/external/commands
```

API headers:

```text
Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY
Content-Type: application/json
```

## Request Envelope

Every API-key command uses this JSON shape:

```json
{
  "command": "subaccounts.list",
  "input": {}
}
```

Successful responses include the command, scope, and returned data:

```json
{
  "command": "subaccounts.list",
  "scope": {
    "teamId": "team-id",
    "siteId": null
  },
  "data": {}
}
```

## Scope And Safety

UXON API keys are team-scoped and may also be restricted to a single `siteId`.

Allowed actions:

- Read setup and reporting data.
- Create and update approved resources.
- Set status for landing pages and experiments.
- Run guided workflows through MCP.

Blocked actions:

- Delete operations.
- Raw internal passthrough endpoints.
- Commands outside the public command catalogue.

Agents should treat publishing pages, starting experiments, changing tracking, and connecting domains as high-impact actions that require explicit operator confirmation.

## Operational Defaults

- Report commands default to the last 30 days when no date range is provided.
- Pagination defaults to `page = 1` and `perPage = 25`.
- `perPage` max is `100` for most list commands.
- Dates should use ISO-8601 strings, such as `2026-04-19T00:00:00.000Z`.
- Supported `dateRange` presets include `last-7-days`, `last-14-days`, `last-30-days`, and `last-90-days`.

## ID Discovery Protocol

Resolve IDs before write commands. Do not guess IDs from names.

1. Run `subaccounts.list` to find a `siteId`.
2. Run `goals.list` to find conversion goals for `selectedGoals`.
3. Run `landing_pages.list` to find landing page IDs.
4. Run `reports.landing_page.details` to find variant IDs.
5. Run `experiments.list` to find experiment IDs.
6. Run `domains.list` to find domain IDs.
7. Run `reports.contacts.list` to find contact IDs.

## Agent Execution Protocol

For every action:

1. Validate command and required fields locally.
2. Resolve IDs first.
3. Send the smallest payload that performs the intended action.
4. Parse the response and verify expected keys.
5. Log command, input, response, and timestamp.
6. For write commands, read the resource back to confirm the result.

## Claude MCP Tool Naming

API commands use dotted names, for example `landing_pages.create`.

Claude MCP tools use underscore names because MCP clients require tool-safe identifiers, for example `landing_pages_create`.

Examples:

| API command | MCP tool |
| --- | --- |
| `subaccounts.list` | `subaccounts_list` |
| `landing_pages.create` | `landing_pages_create` |
| `experiments.create` | `experiments_create` |
| `reports.experiment.details` | `reports_experiment_details` |
| `tracking.setup` | `tracking_setup` |

## High-Value MCP Workflows

### First Client Setup

Tool:

```text
onboarding_first_client_setup
```

Purpose:

Run onboarding, branding, tracking, and domain setup in one guided flow.

Recommended prompt:

```text
Start first client setup for Acme Dental, website https://acmedental.com.
```

The workflow asks for missing inputs, pauses safely when DNS needs external action, and can be resumed with `workflow_status`.

### Landing Page From Brief

Tool:

```text
landing_pages_create_from_brief
```

Purpose:

Create a UXON landing page draft from structured brief fields.

Useful fields:

- `clientReference` or `siteId`
- `lpName`
- `language`
- `funnelStrategy`
- `buyerGroup`
- `desiredAction`
- `market`
- `serviceOrProduct`
- `idealClient`

### Support Q&A From Help Articles

Tools:

```text
docs_search
docs_get
```

Protocol:

1. Search the Help Center with the user's phrase.
2. Fetch the best matching article.
3. Answer from article facts and include the article URL when available.

## Command Catalogue

### Sub-Accounts

#### `subaccounts.list`

List accessible client sub-accounts with a high-level operational snapshot.

```json
{
  "command": "subaccounts.list",
  "input": {}
}
```

#### `subaccounts.get`

Fetch one sub-account by `siteId`.

```json
{
  "command": "subaccounts.get",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `subaccounts.create`

Create a new client sub-account.

```json
{
  "command": "subaccounts.create",
  "input": {
    "name": "Acme Dental",
    "websiteUrl": "https://acmedental.com",
    "reportingCurrency": "USD",
    "landingPageFeedbackMode": "ai_approvals"
  }
}
```

#### `subaccounts.update`

Update sub-account profile fields, reporting currency, or feedback mode.

```json
{
  "command": "subaccounts.update",
  "input": {
    "siteId": "site_uuid",
    "name": "Acme Dental Group"
  }
}
```

### Landing Pages

#### `landing_pages.list`

List landing pages for one sub-account.

```json
{
  "command": "landing_pages.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `landing_pages.create`

Create a landing page and optional initial variants. If variants are omitted, UXON creates a default control variant.

```json
{
  "command": "landing_pages.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer",
    "variants": [
      { "name": "Control" },
      { "name": "Variant B" }
    ]
  }
}
```

#### `landing_pages.update`

Update landing page metadata, settings, knowledge base content, or variant definitions.

```json
{
  "command": "landing_pages.update",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "name": "Spring Offer - Rev 2"
  }
}
```

#### `landing_pages.code_variant.upload`

Upload or replace an externally coded landing page ZIP as a UXON variant.

Use this for static page bundles generated by Claude Code, Codex, Cursor, v0, or a custom build pipeline. Upload the final built output, not source project files. The ZIP must include `index.html` and referenced assets. UXON injects pixels, global scripts, and page metadata automatically.

```json
{
  "command": "landing_pages.code_variant.upload",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantName": "Agent Built Variant",
    "zipUrl": "https://example.com/builds/landing-page.zip",
    "makeMain": false,
    "publish": false
  }
}
```

#### `landing_pages.set_status`

Set a landing page to `draft` or `live`.

```json
{
  "command": "landing_pages.set_status",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "status": "live"
  }
}
```

### Experiments

#### `experiments.list`

List experiments for one sub-account.

```json
{
  "command": "experiments.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `experiments.create`

Create a draft experiment. UXON supports UXON page variants, external URLs, and URL-pattern targets.

Use `selectedGoals` for new integrations. Use `experiments.set_status` to launch after creating the draft.

UXON page experiment:

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
    "trafficAllocation": 100
  }
}
```

Cross-domain external URL experiment:

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

URL-pattern experiment:

```json
{
  "command": "experiments.create",
  "input": {
    "siteId": "site_uuid",
    "nickname": "Pricing Redirect Test",
    "selectedGoals": [
      { "id": "lead_goal_uuid", "name": "Lead" }
    ],
    "controlSource": "url_patterns",
    "variantSource": "external",
    "variantPageUrl": "https://www.example.com/pricing-variant",
    "urlPatterns": {
      "side": "control",
      "conditions": [
        { "type": "include", "operator": "contains", "value": "/pricing" }
      ]
    }
  }
}
```

#### `experiments.update`

Update mutable experiment settings without changing lifecycle status.

```json
{
  "command": "experiments.update",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "trafficAllocation": 60,
    "visitorType": "new-visitors"
  }
}
```

#### `experiments.set_status`

Move an experiment to `Draft`, `Running`, `Paused`, or `Ended`.

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

### Tracking

#### `tracking.setup`

Configure tracking on a domain in GTM mode or direct GA4/Meta mode.

GTM mode installs managed GTM snippets in `head` and `body-start`, and clears direct GA4/Meta IDs to prevent duplicate firing.

```json
{
  "command": "tracking.setup",
  "input": {
    "siteId": "site_uuid",
    "mode": "gtm",
    "domain": "www.example.com",
    "gtmContainerId": "GTM-ABC1234"
  }
}
```

Direct mode disables managed GTM scripts on the selected domain and saves direct GA4/Meta IDs.

```json
{
  "command": "tracking.setup",
  "input": {
    "siteId": "site_uuid",
    "mode": "direct",
    "domain": "www.example.com",
    "ga4MeasurementId": "G-PSW1MY7HB4",
    "metaPixelId": "123456789012345"
  }
}
```

### Domains

#### `domains.list`

List domains for one sub-account.

```json
{
  "command": "domains.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `domains.add`

Add a root domain or subdomain.

```json
{
  "command": "domains.add",
  "input": {
    "siteId": "site_uuid",
    "domain": "example.com",
    "subdomain": "www"
  }
}
```

#### `domains.connect`

Run DNS verification and update domain connection status for an existing domain record.

```json
{
  "command": "domains.connect",
  "input": {
    "domainId": "domain_uuid"
  }
}
```

### Goals

#### `goals.list`

List conversion goals for one sub-account.

```json
{
  "command": "goals.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `goals.create`

Create a custom conversion goal.

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

#### `goals.update`

Update goal metadata or activation status.

```json
{
  "command": "goals.update",
  "input": {
    "siteId": "site_uuid",
    "goalId": "goal_uuid",
    "isActive": true
  }
}
```

### Reports

#### `reports.landing_pages.summary`

Return aggregate landing page totals and conversion metrics.

```json
{
  "command": "reports.landing_pages.summary",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `reports.landing_page.details`

Return detailed landing page data, including variant IDs needed for experiments.

```json
{
  "command": "reports.landing_page.details",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

#### `reports.landing_page.variant_metrics`

Return variant-level metrics for a landing page.

```json
{
  "command": "reports.landing_page.variant_metrics",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

#### `reports.landing_page.trends`

Return time-series landing page metrics.

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

#### `reports.landing_page.channels`

Return landing page performance by attribution channel.

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

#### `reports.experiments.summary`

Return aggregate experiment totals and session split metrics.

```json
{
  "command": "reports.experiments.summary",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `reports.experiment.details`

Return experiment analytics and decision context. Use `conversionGoalId: "all"` for all selected conversions, or pass one selected goal ID.

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

#### `reports.experiment.chart`

Return chart-ready time-series metrics for an experiment.

```json
{
  "command": "reports.experiment.chart",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "dateRange": "last-30-days",
    "conversionGoalId": "all"
  }
}
```

#### `reports.experiment.channels`

Return experiment performance segmented by channel.

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

### Contacts

#### `reports.contacts.list`

List contacts with filters and pagination.

```json
{
  "command": "reports.contacts.list",
  "input": {
    "siteId": "site_uuid",
    "page": 1,
    "perPage": 25
  }
}
```

#### `reports.contacts.detail`

Fetch contact profile and latest submission details.

```json
{
  "command": "reports.contacts.detail",
  "input": {
    "siteId": "site_uuid",
    "contactId": "contact_uuid"
  }
}
```

### Knowledge Base Articles

#### `docs.list`

List Help Center articles available to AI tools.

```json
{
  "command": "docs.list",
  "input": {
    "page": 1,
    "perPage": 20,
    "state": "published"
  }
}
```

#### `docs.search`

Search Help Center articles by phrase.

```json
{
  "command": "docs.search",
  "input": {
    "query": "connect Claude to UXON",
    "perPage": 5,
    "state": "published"
  }
}
```

#### `docs.get`

Fetch one Help Center article by ID.

```json
{
  "command": "docs.get",
  "input": {
    "articleId": "article_id"
  }
}
```

## High-Value Runbooks

### Morning Account Check

1. `subaccounts.list`
2. For each site, run `landing_pages.list` and `experiments.list`.
3. For each site, run `reports.landing_pages.summary` and `reports.experiments.summary`.
4. Summarize live landing pages, running experiments, sessions, conversions, and obvious follow-up actions.

### Onboard A New Client

1. Ask for client name, website URL, reporting currency, and landing page feedback mode.
2. Run `subaccounts.create`.
3. Run `goals.create` for the first conversion goal.
4. Run `landing_pages.create` for the first page.
5. Run `domains.add` and `domains.connect`.
6. Configure tracking with `tracking.setup`.

### Launch A UXON-Page Experiment

1. Run `goals.list` or `goals.create`.
2. Run `landing_pages.list`.
3. Run `reports.landing_page.details` to resolve variant IDs.
4. Run `experiments.create` with UXON control and variant sources.
5. Confirm launch with the operator.
6. Run `experiments.set_status` with `Running`.
7. Monitor with `reports.experiment.details`, `reports.experiment.chart`, and `reports.experiment.channels`.

### Launch A Cross-Domain Experiment

1. Confirm the plan supports external sources.
2. Run `goals.list` or `goals.create`.
3. Run `experiments.create` with `controlSource` and/or `variantSource` set to `external`.
4. Include `controlPageUrl` and/or `variantPageUrl`.
5. Confirm launch with the operator.
6. Run `experiments.set_status` with `Running`.
7. Monitor experiment reports.

### Weekly Optimization Cycle

1. Pull channel and trend reports for landing pages.
2. Pull experiment details, charts, and channel reports.
3. Identify pages or variants with meaningful performance differences.
4. Update experiments or landing page status only after operator confirmation.
5. Record the next recommended test or page action.
