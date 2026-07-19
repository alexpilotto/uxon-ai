# UXON Agent Command Playbook

This playbook describes the public UXON API and MCP command surface for AI agents, automation tools, and developers. It can be used as a Claude skill / Claude Code skill reference for landing page creation, CRO reporting, A/B testing, split testing, conversion tracking, and post-click optimization workflows.

Latest live version:

```text
https://uxon.ai/api/skills
```

This repository file is a readable snapshot. Agents should use the live URL when they need the current command contract.

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

- Raw internal passthrough endpoints.
- Commands outside the public command catalogue.

Agents should treat publishing pages, starting experiments, deleting pages or variants, changing tracking, and connecting domains as high-impact actions that require explicit operator confirmation.

## Operational Defaults

- Report commands default to the last 30 days when no date range is provided.
- Pagination defaults to `page = 1` and `perPage = 25`.
- `perPage` max is `100` for most list commands.
- Dates should use ISO-8601 strings, such as `2026-04-19T00:00:00.000Z`.
- Supported report `dateRange` presets are `today`, `yesterday`, `last-3-days`, `last-7-days`, `last-14-days`, `last-30-days`, `last-90-days`, `last-365-days`, and `custom`.
- For custom report windows, use `dateRange: "custom"` with `from` and `to` as ISO-8601 strings.
- Report `timezone` should be a valid IANA timezone, such as `UTC`, `Australia/Brisbane`, `America/New_York`, or `Europe/London`.
- Default API key rate limit is 60 requests per minute. Responses include `X-RateLimit-Limit`, `X-RateLimit-Remaining`, and `X-RateLimit-Reset`.
- `subaccounts.list.snapshot.landingPages`, `snapshot.experiments`, and `snapshot.domains` are integer counts, not nested objects.

## Agent-Writable Object Contracts

### Landing Page `settings`

For `landing_pages.create` and `landing_pages.update`, agents should only write the publish object:

```json
{
  "publish": {
    "domain": "www.example.com",
    "path": "/offer",
    "hideFromSearch": true
  }
}
```

- `publish.domain`: connected domain hostname.
- `publish.path`: `/` or a published path such as `/offer`.
- `publish.hideFromSearch`: boolean. If `domain` or `path` is provided and `hideFromSearch` is omitted, UXON defaults it to `true`.
- Do not send `settings.published`. That is UXON's internal full page-builder/published snapshot.
- Do not construct page-builder state inside `settings`.

### Landing Page `knowledgeBase`

`knowledgeBase` stores page notes/brief context only. It does not run AI generation.

Recommended shape:

```json
{
  "summary": "Short context for the page",
  "notes": ["Important note"],
  "links": [{ "label": "Brief", "url": "https://example.com" }],
  "raw": {}
}
```

### Experiment `trafficFilters`

`trafficFilters` are exact string key/value tracking filters:

```json
{
  "utm_source": "google",
  "utm_medium": "cpc",
  "utm_campaign": "winter-sale"
}
```

- Runtime compares stored tracking values exactly to the provided value.
- Do not use regex, operators, arrays, includes/contains matching, or country filters.
- Common fields: `utm_source`, `utm_medium`, `utm_campaign`, `utm_content`.
- Also supported when present: `utm_term`, `utm_id`, `utm_source_platform`, `gclid`, `gbraid`, `wbraid`, `fbclid`, `msclkid`, `ttclid`, `li_fat_id`, `twclid`.
- Use `geoFilters` for country targeting.

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

Run first client setup with automatic brand/media import from the website URL. Do not ask the user for brand colors, typography, voice, or logo URL during first setup unless they volunteer those details.

Recommended prompt:

```text
Start first client setup for Acme Dental, website https://acmedental.com.
```

The workflow asks for missing inputs, pauses safely when DNS needs external action, and can be resumed with `workflow_status`.

### Landing Page From Brief

Tool:

```text
landing_pages_generate_from_brief
```

Purpose:

Submit the real UXON AI landing page generation pipeline from structured brief fields.

Useful fields:

- `clientReference` or `siteId`
- `name`
- `brief.brandName`
- `brief.websiteUrl`
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

Create a new client sub-account. UXON automatically starts brand fetching, color/font assignment, and website media scraping from `websiteUrl`.

Accepted feedback modes:

- `free_comments`: reviewers can leave open comments.
- `ai_approvals`: review links use AI-assisted approval decisions.

`reportingTimezone` is optional but recommended for API/MCP agents when known. Use a valid IANA timezone.

```json
{
  "command": "subaccounts.create",
  "input": {
    "name": "Acme Dental",
    "websiteUrl": "https://acmedental.com",
    "reportingCurrency": "USD",
    "reportingTimezone": "Australia/Brisbane",
    "landingPageFeedbackMode": "ai_approvals"
  }
}
```

#### `subaccounts.update`

Update sub-account profile fields, reporting currency, reporting timezone, or feedback mode.

```json
{
  "command": "subaccounts.update",
  "input": {
    "siteId": "site_uuid",
    "name": "Acme Dental Group",
    "reportingTimezone": "Australia/Brisbane"
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

#### `landing_pages.get`

Get landing page metadata, variants, preview URLs, and live URLs.

```json
{
  "command": "landing_pages.get",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

#### `landing_pages.create`

Create a draft landing page with one blank builder `Control` variant. This does not run UXON AI generation.

```json
{
  "command": "landing_pages.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer",
    "settings": {
      "publish": {
        "domain": "www.example.com",
        "path": "/spring-offer",
        "hideFromSearch": true
      }
    },
    "knowledgeBase": {
      "summary": "Emergency dental appointment landing page for new patients.",
      "notes": ["Same-day availability is the key buyer trigger."],
      "links": [],
      "raw": {}
    }
  }
}
```

#### `landing_pages.generate_from_brief`

Submit the real UXON AI landing page generation pipeline from an approved brief.

```json
{
  "command": "landing_pages.generate_from_brief",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer",
    "brief": {
      "brandName": "Acme Dental",
      "websiteUrl": "https://acmedental.com",
      "language": "English (US)",
      "funnelStrategy": "Service",
      "buyerGroup": "Consumers (B2C)",
      "desiredAction": "Submit a form",
      "market": "Brisbane, Queensland",
      "serviceOrProduct": "Emergency dental appointments",
      "idealClient": "Adults with urgent dental pain"
    }
  }
}
```

#### `landing_pages.generation_status`

Poll a UXON AI landing page generation job.

```json
{
  "command": "landing_pages.generation_status",
  "input": {
    "siteId": "site_uuid",
    "jobId": "job_uuid"
  }
}
```

#### `landing_pages.update`

Update landing page metadata, `settings.publish`, or `knowledgeBase`. Use variant commands for variant changes.

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

#### `landing_pages.variants.create`

Create a blank builder/code variant, or duplicate from an existing variant.

```json
{
  "command": "landing_pages.variants.create",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "name": "Variant B",
    "sourceVariantId": "lpv_control_uuid",
    "variantType": "builder"
  }
}
```

#### `landing_pages.variants.get`

Get one landing page variant.

```json
{
  "command": "landing_pages.variants.get",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_uuid"
  }
}
```

#### `landing_pages.variants.update`

Update one variant's name, settings, or builder state.

```json
{
  "command": "landing_pages.variants.update",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_uuid",
    "name": "Variant B - Rev 2"
  }
}
```

#### `landing_pages.variants.set_main`

Set the main variant for a landing page.

```json
{
  "command": "landing_pages.variants.set_main",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_uuid"
  }
}
```

#### `landing_pages.variants.duplicate`

Duplicate one builder variant.

```json
{
  "command": "landing_pages.variants.duplicate",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_uuid",
    "name": "Variant B Copy"
  }
}
```

#### `landing_pages.variants.delete`

Delete one landing page variant. Confirm with the operator first.

```json
{
  "command": "landing_pages.variants.delete",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_uuid"
  }
}
```

#### `landing_pages.duplicate`

Duplicate a landing page and its builder variants.

```json
{
  "command": "landing_pages.duplicate",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "name": "Spring Offer Copy"
  }
}
```

#### `landing_pages.delete`

Delete a landing page. Confirm with the operator first.

```json
{
  "command": "landing_pages.delete",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
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

#### `landing_pages.code_variant.upload_init`

Create a signed upload URL for a custom code ZIP.

Use after creating a code variant with `landing_pages.variants.create` and `variantType: "code"`.

```json
{
  "command": "landing_pages.code_variant.upload_init",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_code_uuid",
    "fileName": "landing-page.zip",
    "size": 248000
  }
}
```

#### `landing_pages.code_variant.upload_complete`

Import a custom code ZIP after the signed upload completes.

```json
{
  "command": "landing_pages.code_variant.upload_complete",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_code_uuid",
    "uploadToken": "returned_upload_token"
  }
}
```

#### `landing_pages.publish_changes`

Publish current draft variant changes to the live page.

```json
{
  "command": "landing_pages.publish_changes",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

#### `landing_pages.review_link`

Create a landing page review link for preview comments or approvals.

```json
{
  "command": "landing_pages.review_link",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
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

#### `experiments.get`

Get one experiment's setup, status, selected goals, targeting, and saved counters.

```json
{
  "command": "experiments.get",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid"
  }
}
```

#### `experiments.create`

Create a draft experiment. UXON supports UXON page variants, external URLs, and URL-pattern targets.

Use `selectedGoals` for new integrations. Use `experiments.set_status` to launch after creating the draft.

Important fields:

- `testTrigger`: `entry` or `visits`.
- `visitorType`: `all-visitors`, `new-visitors`, or `returning-visitors`.
- `deviceType`: `all-devices`, `desktop-only`, or `mobile-only`.
- `trafficAllocation`: number from `0` to `100`.
- `preserveRedirectParams`: default `true`.
- `urlPatterns.conditions[].operator`: `is`, `contains`, `starts_with`, or `ends_with`.
- `urlPatterns` supports up to 5 total conditions and can be used on Control or Variant, not both.
- `geoFilters.countries.type`: `include` or `exclude`.

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
    "trafficAllocation": 100,
    "testTrigger": "entry",
    "visitorType": "all-visitors",
    "deviceType": "all-devices"
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
    "testTrigger": "visits",
    "visitorType": "new-visitors",
    "deviceType": "desktop-only",
    "trafficFilters": {
      "utm_source": "google",
      "utm_campaign": "brand"
    },
    "geoFilters": {
      "countries": {
        "type": "exclude",
        "countryCodes": ["GB"],
        "includeUnknown": true
      }
    }
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

1. Ask for client name, website URL, reporting currency, optional reporting timezone, and landing page feedback mode.
2. Run `subaccounts.create`.
3. Let UXON automatically start brand/color/font/media import from the website URL.
4. Run `goals.create` for the first conversion goal.
5. Run `landing_pages.create` for a blank page, or `landing_pages.generate_from_brief` when the user wants AI page generation.
6. Run `domains.add` and `domains.connect`.
7. Configure tracking with `tracking.setup`.

### Launch A UXON-Page Experiment

1. Run `goals.list` or `goals.create`.
2. Run `landing_pages.list`.
3. Run `landing_pages.get` or `reports.landing_page.details` to resolve variant IDs.
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
