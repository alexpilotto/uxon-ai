# UXON API Keys Agent Playbook

> Maintainer note: when updating MCP/API/SKILLS capabilities, follow `docs/ai-chat-cro-working-agreement.md` and keep parity explicitly aligned.
> MCP parity note: API commands use dotted names in request payloads; Claude MCP tools use underscore names because Claude requires `^[a-zA-Z0-9_-]{1,64}$`.

This document is the operational contract for external agents that execute account setup and reporting actions in UXON.

Use this playbook when agents are running in Slack, custom apps, internal tools, or orchestration platforms.

## 1) Primary Outcomes

Use API Keys commands to:

- discover account and campaign state quickly,
- keep account setup synchronized across tools,
- run controlled setup changes,
- pull recurring performance reports,
- execute repeatable agency workflows with auditability.

## 2) Scope And Limits

Allowed in this API:

- read reporting and setup data,
- create and update approved resources,
- set status for landing pages and experiments,
- delete only resources with explicit approved delete commands.

Blocked in this API:

- delete operations without a listed delete command,
- raw internal passthrough endpoints,
- commands not listed in this document.

## 3) Endpoint And Auth

Endpoint:

`POST https://uxon.ai/api/external/commands`

Latest skills URL:

`GET https://uxon.ai/api/skills`

Agents should fetch the latest skills from this URL when they need the current command playbook. This document contains instructions only; commands still require the bearer API key below.

Headers:

```
Authorization: Bearer uxon_live_...
Content-Type: application/json
```

## 3.1) Claude MCP Quickstart (Autopilot)

For Claude connector users (MCP), the fastest path is a single workflow start:

- Tool: `onboarding_first_client_setup`
- Purpose: run onboarding -> automatic brand/media import -> tracking -> domain setup in one guided flow.

What to expect in chat:

- Claude asks only missing inputs: client name, website URL, reporting currency, reporting timezone only when unknown, landing page feedback mode, tracking setup, and domain setup.
- After the client account is created, UXON automatically starts brand import and website media scraping in the background.
- Do not ask for brand colors, typography, brand voice, or logo URL during first-client setup unless the user explicitly wants a manual branding override.
- Use `branding_setup` separately when the user wants to override the automatic brand import.
- If DNS is still propagating, workflow pauses safely and resumes with `workflow_status`.
- Tracking safety rule is enforced:
  - GTM mode clears direct GA4/Meta IDs.
  - Direct mode disables managed GTM scripts for that domain.

Recommended first prompt in Claude:

- `Start first client setup for [brand name], website [url].`

## 3.2) Claude Support Q&A (Knowledge Articles)

When users ask product/how-to questions in chat:

1. Run `docs_search` with the user phrase.
2. Pick the best match.
3. Run `docs_get` on that article ID.
4. Reply using article facts and include the article URL when available.

## 3.3) Claude Landing Page Brief Workflow

For Claude connector users creating a landing page from brief:

- Tool: `landing_pages_create_from_brief`
- Collect or pass: `clientReference` or `siteId`, `lpName`, `language`, `funnelStrategy`, `buyerGroup`, `desiredAction`, `market`, `serviceOrProduct`, `idealClient`.
- Use the same brief labels as AI landing page generation: Brand name, Website URL, Language, Offer type, Buyer group, Desired action, Market, Promoted offer, Ideal customer.
- If any field is missing, the workflow asks the next missing question.
- The workflow submits the real UXON AI landing page generation job. Poll with `landing_pages_generation_status`, then read the page with `landing_pages_get`.

## 4) Request Envelope

Every request must use this exact envelope:

```json
{
  "command": "subaccounts.list",
  "input": {}
}
```

## 5) Response Envelope

Successful response shape:

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

## 6) Access, Scope, And Safety

- Keys are team-scoped.
- A key may be restricted to one `siteId`.
- If key scope is one site, using another `siteId` is rejected.
- Use only listed commands.
- Delete actions are allowed only for listed delete commands and require exact IDs.
- Unknown commands are rejected.
- Commands are rate-limited and logged per key.
- MCP high-impact write tools require explicit user approval. When the user has approved the action, retry the MCP tool with `confirm: true`.
- MCP OAuth sessions should have both `uxon:read` and `uxon:write`; read-only sessions cannot run write tools.
- MCP create-style tools must include a stable `idempotencyKey` so retries do not create duplicates.
- MCP `tools/list` is the source of truth for connector schemas, including one-of identifier requirements such as `landingPageId` or `id`.
- Direct External API commands do not use `confirm` or `idempotencyKey` in the request body unless the command schema lists them.

## 7) Operational Defaults

Client account defaults:

- `reportingCurrency` defaults to `USD`.
- `reportingTimezone` must be a valid IANA timezone, for example `UTC`, `Australia/Brisbane`, `America/New_York`, or `Europe/London`.
- `reportingTimezone` defaults to `UTC` when omitted through API/MCP.
- Browser onboarding silently sends the user's browser timezone when available. API/MCP agents do not have browser context, so pass the best known client timezone or ask once if unknown.
- `landingPageFeedbackMode` defaults to `free_comments`.

Landing page feedback mode values:

- `free_comments`: clients can place open comments on landing page previews.
- `ai_approvals`: the preview uses the AI-assisted approval workflow to review and moderate feedback.

Do not confuse client account feedback mode with landing-page approval settings:

- `landingPageFeedbackMode` is the client account default.
- A landing page can override the feedback mode in its own approval settings.
- A landing page can set an approval email override.
- A landing page can disable new comments while keeping existing comments visible.
- Optional client logos are handled by branding/logo workflows, not by bare `subaccounts.create`.

Date defaults:

- If date range is omitted on report commands, the API defaults to the last 30 days.
- Report commands with a `timezone` field expect the same IANA timezone format.
- If report `timezone` is omitted, UXON uses the sub-account reporting timezone, then `UTC`.

Pagination defaults:

- `page = 1`
- `perPage = 25`
- `perPage` max is `100`

Date format:

- Use ISO-8601 date strings, for example: `2026-04-19T00:00:00.000Z`

Report `dateRange` presets:

- `today`
- `yesterday`
- `last-3-days`
- `last-7-days`
- `last-14-days`
- `last-30-days`
- `last-90-days`
- `last-365-days`
- `custom`

Custom report windows:

- Recommended: use `dateRange: "custom"` with `from` and `to` as ISO-8601 strings.
- Backwards-compatible: some report commands also accept `dateRange` as `"fromISO,toISO"`.

Rate limits:

- Default API key limit is 60 requests per minute.
- Internal key configuration supports custom limits from 1 to 600 requests per minute.
- Responses include `X-RateLimit-Limit`, `X-RateLimit-Remaining`, and `X-RateLimit-Reset`.
- On `429`, wait for `X-RateLimit-Reset` before retrying.

Bulk reporting behavior:

- For multi-account checks, start with `subaccounts.list`.
- Use snapshot counts to decide where detail is needed.
- Do not fetch every page, variant, experiment, channel, and contact unless the user asks for exhaustive detail.
- Prefer summary commands first, then details only for live/running/high-volume items.
- If `X-RateLimit-Remaining` is low, pause before continuing.

Agent contract:

- Treat listed command schemas as closed contracts. Do not send extra top-level fields.
- Use API dotted command names, for example `subaccounts.create`.
- Use MCP underscore tool names, for example `subaccounts_create`.
- Resolve IDs with list/get commands before write commands.
- For MCP write tools, check `tools/list`. If the schema includes `confirm`, ask the user for approval first and then send `confirm: true`.
- For MCP create tools, send a unique `idempotencyKey`, for example `client-page-2026-07-20-001`.
- For timezone, pass an IANA timezone if the user has supplied locality or timezone. Ask only when it affects reporting and cannot be inferred from the request.
- For client onboarding, do not ask for brand colors, typography, voice, or logo URL unless the user explicitly wants manual branding overrides.
- Use `branding.get` after sub-account creation or before landing page work to inspect saved brand colors, logos, fonts, voice, and readiness.
- Use `branding.update` only when the user explicitly requests manual brand adjustments.
- `branding.update` is partial: send only the fields the user wants to change and preserve everything else.
- Logo upload/import is handled by separate branding/logo workflows where available; do not attempt logo updates through `branding.update`.
- After write commands, read back the changed object and confirm the saved values.

## 8) Full Command Catalog

### Knowledge base articles
- `docs.list`: List Help Center articles available to AI chat tools.
- `docs.search`: Search Help Center articles by phrase.
- `docs.get`: Fetch one Help Center article by ID.

### Sub-accounts
- `subaccounts.list`: List accessible sub-accounts with a high-level operational snapshot.
- `subaccounts.get`: Fetch details and totals for a single sub-account.
- `subaccounts.create`: Create a new sub-account with website URL, reporting currency, reporting timezone, and feedback mode.
- `subaccounts.update`: Update sub-account profile fields, reporting currency, reporting timezone, or feedback mode.

### Branding
- `branding.get`: Fetch a sub-account branding overview including color variables, brand colors, palettes, logos, fonts, brand voice, and readiness flags.
- `branding.update`: Update editable sub-account branding fields such as color variables, brand colors, palette name, and brand voice.

### Landing pages
- `landing_pages.list`: List landing pages for a sub-account.
- `landing_pages.get`: Get landing page metadata, variants, and preview/live URLs.
- `landing_pages.create`: Create a draft landing page with a blank builder variant.
- `landing_pages.update`: Update landing page metadata, settings, or knowledge base.
- `landing_pages.delete`: Delete a landing page.
- `landing_pages.duplicate`: Duplicate a landing page and its builder variants.
- `landing_pages.publish_changes`: Publish current draft variant changes to the live page.
- `landing_pages.review_link`: Create a landing page review link for preview comments or approvals.
- `landing_pages.generate_from_brief`: Start the real UXON AI landing page generation pipeline from an approved brief.
- `landing_pages.generation_status`: Poll a UXON AI landing page generation job.
- `landing_pages.variants.create`: Create a blank builder/code variant or duplicate from an existing variant.
- `landing_pages.variants.get`: Get one landing page variant.
- `landing_pages.variants.update`: Update one landing page variant.
- `landing_pages.variants.set_main`: Set the main variant for a landing page.
- `landing_pages.variants.duplicate`: Duplicate one builder variant.
- `landing_pages.variants.delete`: Delete one landing page variant.
- `landing_pages.code_variant.upload_init`: Create a signed upload URL for a custom code ZIP variant.
- `landing_pages.code_variant.upload_complete`: Import a custom code ZIP after signed upload completes.
- `landing_pages.code_variant.upload`: Upload or replace a custom code ZIP as a landing page variant.
- `landing_pages.set_status`: Set landing page status to draft or live.
- `reports.landing_pages.summary`: Return aggregate landing page totals and conversion metrics.
- `reports.landing_page.details`: Return detailed performance data for a landing page.
- `reports.landing_page.variant_metrics`: Return variant-level metrics for a landing page.
- `reports.landing_page.trends`: Return trend data for a landing page over time.
- `reports.landing_page.channels`: Return landing page performance by attribution channel.

### Experiments
- `experiments.list`: List experiments for a sub-account.
- `experiments.get`: Get one experiment's setup, status, selected goals, targeting, and live all-time pixel totals.
- `experiments.create`: Create a draft experiment with UXON, external, or URL Pattern targets, selectedGoals, and filters.
- `experiments.update`: Update mutable experiment settings, including traffic and Geo filters, without changing status.
- `experiments.set_status`: Set experiment status for run, pause, draft, or end actions.
- `reports.experiments.summary`: Return aggregate experiment totals and session split metrics.
- `reports.experiment.details`: Return detailed analytics and decision context for one experiment, with optional conversionGoalId.
- `reports.experiment.chart`: Return chart-ready time-series metrics for an experiment, with optional conversionGoalId.
- `reports.experiment.channels`: Return experiment performance segmented by channel, with optional conversionGoalId.

### Domains
- `domains.list`: List domains for a sub-account.
- `domains.add`: Add a domain or subdomain to a sub-account.
- `domains.connect`: Run DNS verification and update domain connection status.

### Tracking
- `tracking.setup`: Configure tracking using GTM (head + body) or direct GA4/Meta with anti-duplication guardrails.

### Goals
- `goals.list`: List conversion goals for a sub-account.
- `goals.create`: Create a new conversion goal.
- `goals.update`: Update goal metadata or activation status.

### Contacts
- `reports.contacts.list`: List contacts with filters and pagination.
- `reports.contacts.detail`: Fetch contact profile and latest submission details.

## 9) Agent Execution Protocol (Mandatory)

For every action, follow this order:

1. Validate command and required fields locally before request.
2. Resolve IDs first (never guess IDs).
3. Send minimal payload containing only intended fields.
4. Parse response and verify expected keys are present.
5. Log command + input + response + timestamp for audit.
6. If write command changes state, read back to confirm.

## 10) ID Discovery Protocol

When you do not have IDs, use this sequence:

1. `subaccounts.list` to get `siteId`.
2. `branding.get` to inspect brand readiness for that `siteId`.
3. `goals.list` to get goal IDs for `selectedGoals`.
4. `landing_pages.list` for landing page IDs.
5. `reports.landing_page.details` for landing page variant IDs.
6. `experiments.list` for experiment IDs.
7. `domains.list` for domain IDs.
8. `reports.contacts.list` for contact IDs.

## 11) High-Value Agency Runbooks

### A) Morning account check (what is live + key KPI summary)

Sequence:

1. `subaccounts.list`
2. For each site: `landing_pages.list`, `experiments.list`
3. For each site: `reports.landing_pages.summary`, `reports.experiments.summary`
4. For any account needing detail: `reports.landing_page.details`, `reports.landing_page.channels`, `reports.experiment.details`
5. Produce one per-site summary: live LP count, running experiment count, sessions, conversions, conversion rate/revenue where available, and any obvious attention items.

Bulk behavior:

- Use `dateRange: "last-30-days"` unless the user asks for a different window.
- Process accounts in small batches and watch `X-RateLimit-Remaining`.
- On `429`, wait for `X-RateLimit-Reset` seconds before retrying.
- `subaccounts.list.snapshot.landingPages`, `snapshot.experiments`, and `snapshot.domains` are counts, not full objects.

### B) Onboard a new client and prepare first setup

Sequence:

1. Ask for client name, website URL, reporting currency (default `USD`), reporting timezone only if the client timezone is not known (IANA format; default `UTC`), and landing page feedback mode (default `free_comments`).
2. `subaccounts.create`
3. UXON automatically starts brand import and website media scraping after create.
4. `branding.get` to inspect color variables, brand colors, logos, fonts, brand voice, and readiness.
5. Optional only when requested: `branding.update` for manual brand adjustments, then `branding.get` again to confirm.
6. `tracking.setup`
7. `domains.add`
8. `domains.connect`
9. Optional after setup: `goals.create`, `landing_pages.generate_from_brief` for an AI page, or `landing_pages.create` for a blank builder page, then `landing_pages.set_status` when ready.

### C) Launch a UXON-page experiment safely

Sequence:

1. `goals.list` or `goals.create`
2. `landing_pages.list` to find control/variant pages
3. `reports.landing_page.details` for each selected landing page to get variant IDs
4. `experiments.create` with `selectedGoals`, `controlSource="uxon"`, `variantSource="uxon"`
5. `experiments.set_status` to `Running`
6. Monitor with `reports.experiment.details`, `reports.experiment.chart`

### D) Launch a cross-domain experiment (external URLs)

Sequence:

1. Ensure plan supports external sources.
2. `goals.list` or `goals.create`
3. `experiments.create` with `selectedGoals`, `controlSource="external"` and/or `variantSource="external"`
4. Include required URL(s): `controlPageUrl` and/or `variantPageUrl`
5. `experiments.set_status` to `Running`
6. Monitor using experiment reports.

### E) Weekly optimization cycle

Sequence:

1. `reports.landing_page.channels`
2. `reports.landing_page.trends`
3. `reports.experiment.channels`
4. `reports.experiment.chart`
5. `experiments.update` or `experiments.set_status`
6. `landing_pages.update` or `landing_pages.set_status`

## 12) Command Reference (Detailed)

This section is command-by-command so agents can execute without assumptions.

---

## Sub-accounts

### `subaccounts.list`

Purpose:

- List all accessible sub-accounts and an operational snapshot per account.

Required input:

- none

Optional input:

- none

Request example:

```json
{
  "command": "subaccounts.list",
  "input": {}
}
```

Expected output keys:

- `data.subaccounts[]`
- `id`, `name`, `slug`, `websiteUrl`, `shortId`
- `snapshot.landingPages`, `snapshot.experiments`, `snapshot.domains`

Common failures:

- `401` invalid/missing key
- `403` API Keys not enabled for account

### `subaccounts.get`

Purpose:

- Fetch one sub-account with metadata and totals.

Required input:

- `siteId`

Request example:

```json
{
  "command": "subaccounts.get",
  "input": {
    "siteId": "site_uuid"
  }
}
```

Expected output keys:

- `data.subaccount`
- `snapshot` totals

Common failures:

- `400` missing `siteId`
- `404` sub-account not found

### `subaccounts.create`

Purpose:

- Create a new client sub-account.

Required input:

- `name`
- `websiteUrl`

Validation notes:

- `websiteUrl` must be valid.
- `reportingCurrency` defaults to `USD`; ask the user for the right 3-letter code if it is not obvious.
- `reportingTimezone` must be a valid IANA timezone such as `UTC`, `Australia/Brisbane`, `America/New_York`, or `Europe/London`.
- If a user says the client is in Brisbane, send `Australia/Brisbane`; if they say New York, send `America/New_York`.
- Ask for timezone only if locality/timezone is unknown and local reporting windows matter.
- If omitted, the API stores `UTC`.
- `landingPageFeedbackMode` defaults to `free_comments`.
- Use `free_comments` for open landing page comments.
- Use `ai_approvals` when the user wants the AI-assisted approval workflow to review and moderate feedback.
- `subaccounts.create` automatically starts background brand import and website media scraping.
- Do not ask for brand colors, typography, brand voice, or logo URL during normal client account creation.
- Optional account logos are handled separately through branding/logo tools, not by this command.
- Creation depends on plan limits.

Request example:

```json
{
  "command": "subaccounts.create",
  "input": {
    "name": "ACME Dental",
    "websiteUrl": "https://acmedental.com",
    "reportingCurrency": "USD",
    "reportingTimezone": "Australia/Brisbane",
    "landingPageFeedbackMode": "free_comments"
  }
}
```

Expected output keys:

- `data.subaccount.id`
- `data.subaccount.name`
- `data.subaccount.reportingCurrency`
- `data.subaccount.reportingTimezone`
- `data.subaccount.landingPageFeedbackMode`

Common failures:

- `400` invalid URL or missing required fields
- `403` plan cannot create more sub-accounts

### `subaccounts.update`

Purpose:

- Update sub-account profile fields.

Required input:

- `siteId`

Optional input:

- `name`
- `websiteUrl`
- `reportingCurrency`
- `reportingTimezone`
- `landingPageFeedbackMode`
- `featured`

Request example:

```json
{
  "command": "subaccounts.update",
  "input": {
    "siteId": "site_uuid",
    "name": "ACME Dental Group",
    "reportingCurrency": "AUD",
    "reportingTimezone": "Australia/Brisbane",
    "landingPageFeedbackMode": "ai_approvals"
  }
}
```

Expected output keys:

- `data.subaccount.id`
- `data.subaccount.updatedAt`

Common failures:

- `400` invalid `websiteUrl`
- `404` sub-account not found

---

## Branding

Branding commands inspect and adjust the saved branding used by blank builder pages and AI-generated landing pages.

### `branding.get`

Purpose:

- Fetch a concise branding overview for one sub-account.
- Use this after `subaccounts.create`, before manual page building, or before launching AI generation.

Required input:

- `siteId`

Request example:

```json
{
  "command": "branding.get",
  "input": {
    "siteId": "site_uuid"
  }
}
```

Expected output keys:

- `data.branding.colorVariables`
- `data.branding.brandColors`
- `data.branding.colorPalettes[]`
- `data.branding.logos[]`
- `data.branding.brandVoice`
- `data.branding.fontVariables`
- `data.branding.readiness`

Example `data.branding` shape:

```json
{
  "colorVariables": {
    "pageBackground": "#FFFFFF",
    "headings": "#2F2217",
    "bodyText": "#343433",
    "button": "#F8C80B",
    "buttonText": "#111111",
    "lightBackground": "#F7F7E0",
    "darkBackground": "#2F2217",
    "starRating": "#FDBF01"
  },
  "brandColors": [
    "#F8C80B",
    "#947C1C",
    "#343433",
    "#AA7944",
    "#E4D3B2",
    "#2F2217",
    "#FFFFFF"
  ],
  "logos": [],
  "brandVoice": "",
  "fontVariables": null,
  "readiness": {
    "hasColorVariables": true,
    "hasBrandColors": true,
    "hasLogo": false,
    "hasBrandVoice": false,
    "hasFonts": false,
    "isReady": false
  }
}
```

Readiness notes:

- `readiness.isReady` means UXON has color variables, brand colors, and at least one logo.
- `hasBrandVoice` and `hasFonts` are useful quality signals, not hard blockers.
- Missing logos should be handled through branding/logo workflows where available, not through `branding.update`.

Common failures:

- `400` missing `siteId`
- `404` sub-account not found

### `branding.update`

Purpose:

- Apply explicit manual branding adjustments for a sub-account.
- Use this for quick color variable, palette, or brand voice corrections before landing page work.

Required input:

- `siteId`
- At least one editable field.

Editable fields:

- `colorVariables`: named landing page colors.
- `brandColors`: ordered palette array. Send only when replacing the saved palette.
- `paletteName`: current palette label.
- `brandVoice`: brand voice guidance text.

Preferred `colorVariables` keys:

- `pageBackground`
- `headings`
- `bodyText`
- `button`
- `buttonText`
- `lightBackground`
- `darkBackground`
- `starRating`

Compatibility keys also accepted:

- `page-background`
- `body-text`
- `button-background`
- `button-text`
- `light-background`
- `dark-background`
- `star-rating`

Validation notes:

- This command is partial. Omitted fields are preserved.
- Color values must be 3- or 6-digit hex values, with or without `#`.
- UXON normalizes saved values to uppercase `#RRGGBB`.
- `button` maps to UXON's primary button background color.
- Logo upload/import is not part of this command.
- Run `branding.get` after every update and confirm the saved values.

Request example:

```json
{
  "command": "branding.update",
  "input": {
    "siteId": "site_uuid",
    "colorVariables": {
      "pageBackground": "#FFFFFF",
      "headings": "#2F2217",
      "bodyText": "#343433",
      "button": "#F8C80B",
      "buttonText": "#111111",
      "lightBackground": "#F7F7E0",
      "darkBackground": "#2F2217",
      "starRating": "#FDBF01"
    },
    "brandColors": [
      "#F8C80B",
      "#947C1C",
      "#343433",
      "#AA7944",
      "#E4D3B2",
      "#2F2217",
      "#FFFFFF"
    ],
    "paletteName": "Brand colours",
    "brandVoice": "Clear, useful, confident, and specific. Avoid hype."
  }
}
```

Minimal partial update:

```json
{
  "command": "branding.update",
  "input": {
    "siteId": "site_uuid",
    "colorVariables": {
      "button": "#F8C80B",
      "buttonText": "#111111"
    }
  }
}
```

Expected output keys:

- `data.siteId`
- `data.updatedFields[]`
- `data.branding`

Common failures:

- `400` no editable fields, invalid color, or missing `siteId`
- `404` sub-account not found

---

## Landing pages

### `landing_pages.list`

Purpose:

- List landing pages for one sub-account.

Required input:

- `siteId`

Request example:

```json
{
  "command": "landing_pages.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

Expected output keys:

- `data.landingPages[]`
- `id`, `name`, `status`, `variantCount`, metrics summary fields

Common failures:

- `400` missing `siteId`

### `landing_pages.create`

Purpose:

- Create a draft landing page with one blank builder variant.

Required input:

- `siteId`
- `name`

Optional input:

- `settings`
- `knowledgeBase`

Important behavior:

- UXON creates one blank `Control` builder variant.
- The blank variant uses existing brand colors, fonts, logos, and quick-setup defaults when they exist.
- This does not run UXON AI landing page generation. Use `landing_pages.generate_from_brief` for that.
- `settings` is a JSON object. The agent-writable shape is `{ "publish": { "domain": "www.example.com", "path": "/offer", "hideFromSearch": true } }`.
- `settings.publish.domain` should be a connected domain hostname. `settings.publish.path` should be `/` or a published path such as `/offer`.
- `settings.publish.hideFromSearch` is a boolean. If `domain` or `path` is provided and `hideFromSearch` is omitted, UXON defaults it to `true`.
- Do not send `settings.published`. That is UXON's internal full page-builder/published snapshot.
- Do not construct page-builder state inside `settings`.
- `knowledgeBase` is a JSON object for notes/brief context. It is stored; it does not trigger AI research or generation.
- Recommended `knowledgeBase` shape: `{ "summary": "Short context", "notes": ["Important note"], "links": [{ "label": "Brief", "url": "https://example.com" }], "raw": {} }`.

Request example:

```json
{
  "command": "landing_pages.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Summer Promo"
  }
}
```

Expected output keys:

- `data.landingPage.id`
- `data.landingPage.variants[]`

Common failures:

- `400` missing required fields
- `403` feature not in plan

### `landing_pages.update`

Purpose:

- Update landing page metadata, settings, or knowledge base.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Optional input:

- `name`
- `settings`
- `knowledgeBase`

Important behavior:

- Do not send `status`; use `landing_pages.set_status`.
- Do not send variant changes; use `landing_pages.variants.*`.
- This does not run UXON AI landing page generation.
- `settings` and `knowledgeBase` use the same object shapes as `landing_pages.create`.
- If updating publish settings, send only the `settings.publish` object. Do not send `settings.published` or builder state.

Request example:

```json
{
  "command": "landing_pages.update",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "name": "Summer Promo - Rev 2"
  }
}
```

Common failures:

- `400` missing page id
- `404` landing page not found

### `landing_pages.get`

Purpose:

- Get landing page metadata, variants, and preview/live URLs.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Request example:

```json
{
  "command": "landing_pages.get",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

Expected output keys:

- `data.landingPage.id`
- `data.landingPage.urls.previewUrl`
- `data.landingPage.urls.liveUrl`
- `data.landingPage.variants[]`

### `landing_pages.generate_from_brief`

Purpose:

- Start the real UXON AI landing page generation pipeline from an approved brief.
- Use this when the user asks to create or generate an AI landing page.

Required input:

- `siteId`
- `brief`
- one of `landingPageId`, `pageId`, or `name`

Brief object fields:

- `brandName`
- `websiteUrl`
- `language`
- `funnelStrategy`
- `buyerGroup`
- `desiredAction`
- `market`
- `serviceOrProduct`
- `idealClient`
- optional `selectedProduct`

Important behavior:

- If `landingPageId` or `pageId` is provided, UXON adds an AI-generated variant to that landing page.
- If only `name` is provided, UXON first creates a draft landing page shell, then starts AI generation.
- The command returns immediately with a `jobId`. Poll `landing_pages.generation_status`.
- The page is not automatically published.
- Build requests are not exposed through API/MCP. Paid done-for-you landing page build requests require in-app checkout/payment.

Request example:

```json
{
  "command": "landing_pages.generate_from_brief",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer",
    "brief": {
      "brandName": "ACME Dental",
      "websiteUrl": "https://www.acmedental.com",
      "language": "English (US)",
      "funnelStrategy": "Service",
      "buyerGroup": "Consumers (B2C)",
      "desiredAction": "Submit a form",
      "market": "Brisbane, Queensland",
      "serviceOrProduct": "Emergency dental appointments for new patients",
      "idealClient": "Adults with urgent dental pain who need a same-day appointment"
    }
  }
}
```

Expected output keys:

- `data.landingPage.id`
- `data.generation.jobId`
- `data.generation.variantId`
- `data.generation.stage`

### `landing_pages.generation_status`

Purpose:

- Poll a UXON AI landing page generation job.

Required input:

- `siteId`
- `jobId`

Request example:

```json
{
  "command": "landing_pages.generation_status",
  "input": {
    "siteId": "site_uuid",
    "jobId": "job_uuid"
  }
}
```

Expected output keys:

- `data.generation.status`
- `data.generation.stage`
- `data.generation.progress`
- `data.generation.error`

### `landing_pages.variants.create`

Purpose:

- Create a blank builder variant, duplicate a builder variant, or create an empty code variant.

Required input:

- `siteId`
- `landingPageId`

Optional input:

- `name`
- `sourceVariantId` to duplicate an existing builder variant
- `variantType`: `builder` or `code`
- `makeMain`

### `landing_pages.variants.get`

Purpose:

- Get one landing page variant, including builder state when available.

Required input:

- `siteId`
- `landingPageId`
- `variantId`

### `landing_pages.variants.update`

Purpose:

- Update one variant's name, settings, or builder state.

Required input:

- `siteId`
- `landingPageId`
- `variantId`

Optional input:

- `name`
- `settings`
- `builderState`

### `landing_pages.variants.set_main`

Purpose:

- Set the main variant for a landing page.

Required input:

- `siteId`
- `landingPageId`
- `variantId`

### `landing_pages.variants.duplicate`

Purpose:

- Duplicate one builder variant.

Required input:

- `siteId`
- `landingPageId`
- `variantId`

Optional input:

- `name`
- `makeMain`

### `landing_pages.variants.delete`

Purpose:

- Delete one landing page variant.

Required input:

- `siteId`
- `landingPageId`
- `variantId`

### `landing_pages.duplicate`

Purpose:

- Duplicate a landing page and its builder variants as a new draft.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Optional input:

- `name`

### `landing_pages.delete`

Purpose:

- Delete a landing page if it is not used by an experiment.

Required input:

- `siteId`
- one of `landingPageId` or `id`

### `landing_pages.publish_changes`

Purpose:

- Publish current draft changes for an already-live landing page.

Required input:

- `siteId`
- one of `landingPageId` or `id`

### `landing_pages.review_link`

Purpose:

- Create a review link for the main or specified variant.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Optional input:

- `variantId`
- `variantKey`

### `landing_pages.code_variant.upload_init`

Purpose:

- Create a signed upload URL for a custom code ZIP variant.

Required input:

- `siteId`
- `landingPageId`
- `variantId`
- `fileName` ending in `.zip`
- `size` in bytes

Important behavior:

- Use after creating a code variant with `landing_pages.variants.create` and `variantType="code"`.
- Upload the ZIP to the returned `uploadUrl` using `contentType`.
- Then call `landing_pages.code_variant.upload_complete` with the returned `uploadToken`.

### `landing_pages.code_variant.upload_complete`

Purpose:

- Import a custom code ZIP after the signed upload completes.

Required input:

- `siteId`
- `landingPageId`
- `variantId`
- `uploadToken`

### `landing_pages.code_variant.upload`

Purpose:

- Upload or replace a custom externally coded landing page ZIP as a UXON variant.
- Use this for Claude Code, Codex, Cursor, or other tools that generate a static page bundle outside UXON.

Required input:

- `siteId`
- one of `landingPageId` or `id`
- exactly one of `zipBase64` or `zipUrl`

Optional input:

- `variantId` to replace an existing code variant ZIP
- `variantName` when creating a new code variant
- `fileName` ending in `.zip`
- `makeMain` to make the uploaded variant the main variant
- `publish` to publish the landing page after upload

ZIP format:

- Upload final built static output, not source project files.
- Include `index.html` and all referenced assets in the ZIP.
- Supported assets include CSS, JS, JSON, SVG, images, fonts, audio/video, manifest, XML, source maps, and WASM.
- Maximum ZIP size is 250MB.
- UXON injects pixels, Global Scripts, and page metadata automatically.

Important behavior:

- If `variantId` is omitted, UXON creates a new code variant.
- If `variantId` is provided, UXON replaces that variant's ZIP.
- `publish` defaults to `false`; use `landing_pages.set_status` later or pass `publish: true` when ready.
- `makeMain` defaults to `false`; pass `makeMain: true` only when this variant should receive main traffic.

Request example with `zipUrl`:

```json
{
  "command": "landing_pages.code_variant.upload",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantName": "Claude Code Variant",
    "zipUrl": "https://example.com/builds/landing-page.zip",
    "makeMain": false,
    "publish": false
  }
}
```

Request example with `zipBase64`:

```json
{
  "command": "landing_pages.code_variant.upload",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "variant_uuid",
    "fileName": "landing-page.zip",
    "zipBase64": "UEsDB...",
    "makeMain": true,
    "publish": true
  }
}
```

Expected output keys:

- `data.variant.id`
- `data.variant.urlKey`
- `data.upload.status`
- `data.urls.previewUrl`
- `data.urls.liveUrl`

Common failures:

- `400` missing page id, missing ZIP source, unsupported ZIP format, or ZIP too large
- `403` custom code pages not included in plan
- `404` landing page or variant not found

### `landing_pages.set_status`

Purpose:

- Set page status to `draft` or `live`.

Required input:

- `siteId`
- one of `landingPageId` or `id`
- `status` (`draft` or `live`)

Request example:

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

Common failures:

- `400` invalid status or missing id
- `404` landing page not found

### `reports.landing_pages.summary`

Purpose:

- Aggregate landing page KPIs for one site.
- Page counts are current landing-page inventory.
- Sessions, conversions, unique conversions, and revenue are calculated from pixel tracking data inside the selected reporting window.
- Conversion totals exclude `PageView` and `Bounce`.

Required input:

- `siteId`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`

Request example:

```json
{
  "command": "reports.landing_pages.summary",
  "input": {
    "siteId": "site_uuid",
    "dateRange": "last-30-days"
  }
}
```

Expected output keys:

- `data.summary.totalPages`
- `data.summary.livePages`
- `data.summary.draftPages`
- `data.summary.sessions`
- `data.summary.conversions`
- `data.summary.uniqueConversions`
- `data.summary.revenue`
- `data.summary.dateRange`

### `reports.landing_page.details`

Purpose:

- Detailed landing page record with variants and comparison summary.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`

Important use:

- Use this command to get landing page variant IDs needed for experiments.

Request example:

```json
{
  "command": "reports.landing_page.details",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

Expected output keys:

- `data.landingPage.id`
- `data.landingPage.name`
- `data.landingPage.slug`
- `data.landingPage.status`
- `data.landingPage.variants[]`
- `data.landingPage.variants[].id`
- `data.landingPage.variants[].name`
- `data.landingPage.variants[].isMain`
- `data.landingPage.variants[].urlKey`
- `data.summary.sessions`
- `data.summary.allEvents`
- `data.summary.uniqueConversions`
- `data.summary.conversionRate`
- `data.summary.revenue`

### `reports.landing_page.variant_metrics`

Purpose:

- Variant-level KPI rows for one landing page.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`

Request example:

```json
{
  "command": "reports.landing_page.variant_metrics",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid"
  }
}
```

Expected output keys:

- `data.metrics[]`
- `data.metrics[].variantId`
- `data.metrics[].variantName`
- `data.metrics[].sessions`
- `data.metrics[].conversions`
- `data.metrics[].uniqueConversions`
- `data.metrics[].conversionRate`
- `data.metrics[].revenue`

### `reports.landing_page.trends`

Purpose:

- Time-series trends for landing page metrics.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`
- `metric`
- `granularity` (`day`, `week`, `month`)

Request example:

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

Expected output keys:

- `data.granularity`
- `data.chartDataByMetric`
- `data.chartDataByMetric.sessions[]`
- `data.chartDataByMetric.conversions[]`
- `data.chartDataByMetric.revenue[]`
- `data.chartDataByMetric.conversion_rate[]`

### `reports.landing_page.channels`

Purpose:

- Channel attribution view for one landing page.

Required input:

- `siteId`
- one of `landingPageId` or `id`

Optional input:

- `eventId` (goal/event filter)
- `dateRange`
- `from`
- `to`
- `timezone`

Request example:

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

Expected output keys:

- `data.rows[]`
- `data.rows[].channel`
- `data.rows[].sessions`
- `data.rows[].conversions`
- `data.rows[].conversionRate`
- `data.rows[].revenue`

---

## Experiments

### `experiments.list`

Purpose:

- List experiments for one sub-account.
- Includes live all-time control/variant session and conversion totals calculated from pixel tracking data.

Required input:

- `siteId`

Request example:

```json
{
  "command": "experiments.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

Expected output keys:

- `data.experiments[]`
- `id`, `nickname`, `status`, `goal`, `startedAt`, `endedAt`
- live totals: `sessions`, `controlSessions`, `variantSessions`, `controlLeads`, `variantLeads`

### `experiments.get`

Purpose:

- Get one experiment's saved setup and current status.
- Use this to inspect configuration before updating or launching.
- Use report commands for date-range performance metrics.
- `totals` are live all-time pixel totals, not stale saved counters.

Required input:

- `siteId`
- one of `experimentId` or `id`

Request example:

```json
{
  "command": "experiments.get",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid"
  }
}
```

Expected output keys:

- `data.experiment`
- `id`, `nickname`, `status`, `hypothesis`
- `goals[]`
- control setup: `controlSource`, `controlLandingPage`, `controlVariant`, `controlPageUrl`
- variant setup: `variantSource`, `variantLandingPage`, `variantVariant`, `variantPageUrl`
- targeting setup: `trafficAllocation`, `testTrigger`, `visitorType`, `deviceType`
- filters: `trafficFilters`, `urlPatterns`, `geoFilters`, `preserveRedirectParams`
- live totals: `totals.controlSessions`, `totals.variantSessions`, `totals.controlConversions`, `totals.variantConversions`

### `experiments.create`

Purpose:

- Create a new experiment in `Draft` status.

Required input:

- `siteId`
- `nickname`
- goal selector:
  - recommended: `selectedGoals`
  - legacy-compatible: `goalId` or `goal` (goal name)
- target setup for control and variant:
  - If source is `uxon`, provide landing page and variant IDs.
  - If source is `external`, provide page URL.
  - If source is `url_patterns`, provide `urlPatterns`.

Conditional requirements:

- control side:
  - `controlSource = "uxon"` requires `controlLandingPage` + `controlVariant`
  - `controlSource = "external"` requires `controlPageUrl`
  - `controlSource = "url_patterns"` requires `urlPatterns.side = "control"`
- variant side:
  - `variantSource = "uxon"` requires `variantLandingPage` + `variantVariant`
  - `variantSource = "external"` requires `variantPageUrl`
  - `variantSource = "url_patterns"` requires `urlPatterns.side = "variant"`

Optional tuning fields:

- `experimentTitle`
- `hypothesis`
- `testTrigger`: `entry`, `visits`
- `visitorType`: `all-visitors`, `new-visitors`, `returning-visitors`
- `deviceType`: `all-devices`, `desktop-only`, `mobile-only`
- `trafficAllocation` (or `trafficSplit`)
- `trafficFilters`
- `urlPatterns`
- `geoFilters`
- `preserveRedirectParams` (default `true`)

Critical note:

- This command creates `Draft` only.
- Use `selectedGoals` for new agents. Keep `goalId` / `goal` only for old integrations.
- Bounce cannot be combined with another goal.
- URL Patterns can be used on Control or Variant, not both.
- URL Patterns support up to 5 total conditions.
- `preserveRedirectParams` keeps source query parameters on experiment redirects unless set to `false`.
- Use `experiments.set_status` with `Running` to launch.
- `trafficFilters` are exact string key-value filters. Runtime compares stored tracking value exactly to the provided value.
- `trafficFilters` do not support regex, operators, arrays, includes/contains matching, or country targeting.
- Common app fields: `utm_source`, `utm_medium`, `utm_campaign`, `utm_content`.
- Other stored tracking keys that can be matched when present: `utm_term`, `utm_id`, `utm_source_platform`, `gclid`, `gbraid`, `wbraid`, `fbclid`, `msclkid`, `ttclid`, `li_fat_id`, `twclid`.
- Do not put country filters in `trafficFilters`; use `geoFilters`.
- `geoFilters.countries.type` is `include` or `exclude`.
- `urlPatterns.conditions[].operator` is `is`, `contains`, `starts_with`, or `ends_with`.

UXON-to-UXON request example:

```json
{
  "command": "experiments.create",
  "input": {
    "siteId": "site_uuid",
    "nickname": "Headline Test",
    "selectedGoals": [
      { "id": "lead_goal_uuid", "name": "Lead" },
      { "id": "call_goal_uuid", "name": "Phone call" }
    ],
    "controlSource": "uxon",
    "controlLandingPage": "lp_control_uuid",
    "controlVariant": "lpv_control_uuid",
    "variantSource": "uxon",
    "variantLandingPage": "lp_variant_uuid",
    "variantVariant": "lpv_variant_uuid",
    "testTrigger": "entry",
    "trafficAllocation": 100,
    "visitorType": "all-visitors",
    "deviceType": "all-devices"
  }
}
```

Cross-domain request example:

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

URL Pattern request example:

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
        { "type": "include", "operator": "contains", "value": "/pricing" },
        { "type": "exclude", "operator": "contains", "value": "/internal" }
      ]
    }
  }
}
```

Geo filters example:

```json
{
  "geoFilters": {
    "countries": {
      "type": "include",
      "countryCodes": ["AU", "NZ"],
      "includeUnknown": false
    }
  }
}
```

Common failures:

- `400` missing conditional source fields
- `400` selected goal not found
- `400` Bounce combined with another goal
- `400` invalid URL Pattern or Geo filter setup
- `403` external sources not allowed by plan
- `403` traffic or Geo filters not allowed by plan

### `experiments.update`

Purpose:

- Update mutable experiment settings (not status).

Required input:

- `siteId`
- one of `experimentId` or `id`

Optional input:

- `nickname`
- `hypothesis`
- `testTrigger`: `entry`, `visits`
- `trafficAllocation`
- `visitorType`: `all-visitors`, `new-visitors`, `returning-visitors`
- `deviceType`: `all-devices`, `desktop-only`, `mobile-only`
- `trafficFilters`
- `geoFilters`
- `preserveRedirectParams`

Important behavior:

- Status changes are blocked here.
- Use `experiments.set_status` for lifecycle transitions.
- Target pages, URL Patterns side, and selected goals are chosen at creation. The app detail page treats those as setup fields, not normal post-create edits.

Request example:

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

### `experiments.set_status`

Purpose:

- Move experiment to `Draft`, `Running`, `Paused`, or `Ended`.

Required input:

- `siteId`
- one of `experimentId` or `id`
- `status`

Allowed values:

- `Draft`
- `Running`
- `Paused`
- `Ended`

Request example:

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

Launch checks:

- Valid external URL sources when external pages are used.
- Plan support for cross-domain sources.

### `reports.experiments.summary`

Purpose:

- Aggregate experiment totals for a site.

Required input:

- `siteId`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`

Request example:

```json
{
  "command": "reports.experiments.summary",
  "input": {
    "siteId": "site_uuid"
  }
}
```

Expected output keys:

- `data.summary.totalExperiments`
- `data.summary.runningExperiments`
- `data.summary.draftExperiments`
- `data.summary.endedExperiments`
- `data.summary.sessions`
- `data.summary.controlSessions`
- `data.summary.variantSessions`

### `reports.experiment.details`

Purpose:

- Detailed experiment record plus KPI comparison.

Required input:

- `siteId`
- one of `experimentId` or `id`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`
- `conversionGoalId`

Conversion goal behavior:

- Omit `conversionGoalId` or use `"all"` for all selected conversions.
- Use a selected goal ID to report one conversion only.

Request example:

```json
{
  "command": "reports.experiment.details",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid"
  }
}
```

Expected output keys:

- `data.experiment.id`
- `data.experiment.nickname`
- `data.experiment.status`
- `data.experiment.controlSource`
- `data.experiment.variantSource`
- `data.experiment.controlLandingPage`
- `data.experiment.controlVariant`
- `data.experiment.variantLandingPage`
- `data.experiment.variantVariant`
- `data.experiment.controlPageUrl`
- `data.experiment.variantPageUrl`
- `data.experiment.goals`
- `data.experiment.selectedConversionGoalId`
- `data.experiment.trafficAllocation`
- `data.experiment.testTrigger`
- `data.experiment.visitorType`
- `data.experiment.deviceType`
- `data.experiment.trafficFilters`
- `data.experiment.geoFilters`
- `data.metrics.sessions`
- `data.metrics.goals`
- `data.metrics.conversionRate`
- `data.metrics.revenue`
- `data.metrics.probabilityToWin`

### `reports.experiment.chart`

Purpose:

- Chart-ready time series for sessions, goals, revenue, conversion rate.

Required input:

- `siteId`
- one of `experimentId` or `id`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`
- `conversionGoalId`

Conversion goal behavior:

- Omit `conversionGoalId` or use `"all"` for all selected conversions.
- Use a selected goal ID to chart one conversion only.

Request example:

```json
{
  "command": "reports.experiment.chart",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "dateRange": "last-30-days"
  }
}
```

Expected output keys:

- `data.granularity`
- `data.experiment.goals`
- `data.experiment.selectedConversionGoalId`
- `data.sessions[]`
- `data.goals[]`
- `data.revenue[]`
- `data.conversionRate[]`

### `reports.experiment.channels`

Purpose:

- Channel-level performance split by control vs variant.

Required input:

- `siteId`
- one of `experimentId` or `id`

Optional input:

- `dateRange`
- `from`
- `to`
- `timezone`
- `conversionGoalId`

Conversion goal behavior:

- Omit `conversionGoalId` or use `"all"` for all selected conversions.
- Use a selected goal ID to segment one conversion only.

Request example:

```json
{
  "command": "reports.experiment.channels",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "exp_uuid",
    "dateRange": "last-30-days"
  }
}
```

Expected output keys:

- `data.experiment.goals`
- `data.experiment.selectedConversionGoalId`
- `data.rows[]`
- `data.rows[].channel`
- `data.rows[].controlSessions`
- `data.rows[].variantSessions`
- `data.rows[].controlConversions`
- `data.rows[].variantConversions`
- `data.rows[].lift`
- `data.rows[].confidence`
- `controlSessions`, `variantSessions`, `controlConversions`, `variantConversions`, `lift`, `confidence`

---

## Domains

### `domains.list`

Purpose:

- List domains for one sub-account.

Required input:

- `siteId`

Request example:

```json
{
  "command": "domains.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

Expected output keys:

- `domains[]`
- `id`, `domain`, `subdomain`, `status`, `ssl`, `connectedAt`

### `domains.add`

Purpose:

- Add root domain or subdomain.

Required input:

- `siteId`
- `domain`

Optional input:

- `subdomain`

Validation notes:

- Domain format validated.
- Duplicate host/subdomain combinations are rejected.

Request example:

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

### `domains.connect`

Purpose:

- Trigger verification/connect flow for existing domain record.

Required input:

- `domainId`

Request example:

```json
{
  "command": "domains.connect",
  "input": {
    "domainId": "domain_uuid"
  }
}
```

Common failures:

- `400` missing `domainId`
- `404` domain not found

---

## Tracking

### `tracking.setup`

Purpose:

- Configure tracking safely in one command.
- Install GTM managed snippets (`head` + `body-start`) or direct GA4/Meta IDs.
- Prevent duplicate loading by never keeping GTM and direct IDs active together.

Required input:

- `siteId`
- `mode` (`gtm` or `direct`)
- `domain` (host only, for example `www.example.com`)

Mode-specific required input:

- If `mode=gtm`: `gtmContainerId`
- If `mode=direct`: at least one of `ga4MeasurementId` or `metaPixelId`

Guardrails:

- In `gtm` mode:
  - managed GTM scripts are installed in `head` and `body-start`
  - direct GA4/Meta IDs are cleared to prevent duplicate firing
- In `direct` mode:
  - managed GTM scripts are disabled on the selected domain
  - direct GA4/Meta IDs are saved

Request examples:

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

---

## Goals

### `goals.list`

Purpose:

- List goals for one sub-account.

Required input:

- `siteId`

Optional input:

- `page`
- `perPage`

Request example:

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

Expected output keys:

- `goals[]`
- `id`, `name`, `isActive`, `isSystemEvent`, `lastTriggered`

### `goals.create`

Purpose:

- Create a custom conversion goal.

Required input:

- `siteId`
- `name`

Optional input:

- `isActive`
- `googleAdsConversionId`
- `googleAdsConversionLabel`
- `googleAdsEnabled`

Request example:

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

### `goals.update`

Purpose:

- Update goal attributes.

Required input:

- `siteId`
- one of `goalId` or `id`

Optional input:

- `name`
- `isActive`
- `googleAdsConversionId`
- `googleAdsConversionLabel`
- `googleAdsEnabled`

Guardrails:

- System-goal restrictions apply.
- Only Lead system goal can update Google Ads settings.

Request example:

```json
{
  "command": "goals.update",
  "input": {
    "siteId": "site_uuid",
    "goalId": "goal_uuid",
    "googleAdsEnabled": true
  }
}
```

---

## Contacts

### `reports.contacts.list`

Purpose:

- Paginated contacts list with optional filters.

Required input:

- `siteId`

Optional input:

- `page`
- `perPage`
- `search`
- `landingPageId`
- `startDate`
- `endDate`

Request example:

```json
{
  "command": "reports.contacts.list",
  "input": {
    "siteId": "site_uuid",
    "page": 1,
    "perPage": 25,
    "startDate": "2026-03-20T00:00:00.000Z",
    "endDate": "2026-04-19T23:59:59.999Z"
  }
}
```

Expected output keys:

- `data.contacts[]`
- `data.contacts[].id`
- `data.contacts[].firstName`
- `data.contacts[].lastName`
- `data.contacts[].email`
- `data.contacts[].phone`
- `data.contacts[].landingPageName`
- `data.contacts[].variantName`
- `data.contacts[].pageUrl`
- `data.contacts[].submittedAt`
- `data.contacts[].utmSource`
- `data.contacts[].utmMedium`
- `data.contacts[].utmCampaign`
- `data.contacts[].utmContent`
- `data.contacts[].userType`
- `data.contacts[].deviceType`
- `data.pagination.page`
- `data.pagination.perPage`
- `data.pagination.total`

### `reports.contacts.detail`

Purpose:

- Detailed profile for one contact.

Required input:

- `siteId`
- one of `contactId` or `id`

Request example:

```json
{
  "command": "reports.contacts.detail",
  "input": {
    "siteId": "site_uuid",
    "contactId": "contact_uuid"
  }
}
```

Expected output keys:

- `data.contact.id`
- `data.contact.firstName`
- `data.contact.lastName`
- `data.contact.email`
- `data.contact.phone`
- `data.contact.landingPageName`
- `data.contact.variantName`
- `data.contact.submittedAt`
- `data.contact.referrerUrl`
- `data.contact.utmSource`
- `data.contact.utmMedium`
- `data.contact.utmCampaign`
- `data.contact.utmContent`
- `data.contact.userType`
- `data.contact.deviceType`
- `data.latestSubmission`
- `data.latestSubmission.id`
- `data.latestSubmission.pageUrl`
- `data.latestSubmission.referrerUrl`
- `data.latestSubmission.deviceType`
- `data.latestSubmission.submittedAt`
- `data.latestSubmission.values`

---

## Knowledge Base Articles

### `docs.list`

Purpose:

- List Intercom Help Center articles for AI chat knowledge access.

Optional input:

- `page`
- `perPage` (max 50)
- `state` (`published` or `draft`)

Request example:

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

Expected output keys:

- `docs[]`
- `pagination`

### `docs.search`

Purpose:

- Search Intercom Help Center articles by phrase.

Required input:

- `query`

Optional input:

- `page`
- `perPage` (max 50)
- `state` (`published` or `draft`)

Request example:

```json
{
  "command": "docs.search",
  "input": {
    "query": "connect domain",
    "page": 1,
    "perPage": 10,
    "state": "published"
  }
}
```

Expected output keys:

- `query`
- `docs[]`
- `pagination`

### `docs.get`

Purpose:

- Fetch one Intercom Help Center article by ID.

Required input:

- one of `articleId` or `id`

Request example:

```json
{
  "command": "docs.get",
  "input": {
    "articleId": "15284583"
  }
}
```

Expected output keys:

- `doc`

---

## 13) Copy-Paste cURL Templates

Replace values before execution.

### Template wrapper

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command": "REPLACE_COMMAND",
    "input": {}
  }'
```

### cURL: subaccounts.list

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"subaccounts.list","input":{}}'
```

### cURL: subaccounts.create

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"subaccounts.create",
    "input":{"name":"ACME Dental","websiteUrl":"https://acmedental.com","reportingCurrency":"USD","reportingTimezone":"Australia/Brisbane","landingPageFeedbackMode":"free_comments"}
  }'
```

### cURL: landing_pages.create

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"landing_pages.create",
    "input":{"siteId":"site_uuid","name":"Spring Offer"}
  }'
```

### cURL: landing_pages.set_status

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"landing_pages.set_status",
    "input":{"siteId":"site_uuid","landingPageId":"lp_uuid","status":"live"}
  }'
```

### cURL: reports.landing_pages.summary

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"reports.landing_pages.summary",
    "input":{"siteId":"site_uuid"}
  }'
```

### cURL: reports.landing_page.details

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"reports.landing_page.details",
    "input":{"siteId":"site_uuid","landingPageId":"lp_uuid"}
  }'
```

### cURL: experiments.create (UXON source)

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"experiments.create",
    "input":{
      "siteId":"site_uuid",
      "nickname":"Headline Test",
      "selectedGoals":[
        {"id":"lead_goal_uuid","name":"Lead"}
      ],
      "controlSource":"uxon",
      "controlLandingPage":"lp_control_uuid",
      "controlVariant":"lpv_control_uuid",
      "variantSource":"uxon",
      "variantLandingPage":"lp_variant_uuid",
      "variantVariant":"lpv_variant_uuid"
    }
  }'
```

### cURL: experiments.set_status

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"experiments.set_status",
    "input":{"siteId":"site_uuid","experimentId":"exp_uuid","status":"Running"}
  }'
```

### cURL: experiments.get

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"experiments.get",
    "input":{"siteId":"site_uuid","experimentId":"exp_uuid"}
  }'
```

### cURL: reports.experiment.details

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"reports.experiment.details",
    "input":{"siteId":"site_uuid","experimentId":"exp_uuid","conversionGoalId":"all"}
  }'
```

### cURL: reports.experiment.chart

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"reports.experiment.chart",
    "input":{"siteId":"site_uuid","experimentId":"exp_uuid","dateRange":"last-30-days","conversionGoalId":"all"}
  }'
```

### cURL: reports.experiment.channels

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"reports.experiment.channels",
    "input":{"siteId":"site_uuid","experimentId":"exp_uuid","dateRange":"last-30-days","conversionGoalId":"all"}
  }'
```

### cURL: domains.add

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"domains.add",
    "input":{"siteId":"site_uuid","domain":"example.com","subdomain":"www"}
  }'
```

### cURL: domains.connect

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"domains.connect","input":{"domainId":"domain_uuid"}}'
```

### cURL: tracking.setup (GTM mode)

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"tracking.setup",
    "input":{
      "siteId":"site_uuid",
      "mode":"gtm",
      "domain":"www.example.com",
      "gtmContainerId":"GTM-ABC1234"
    }
  }'
```

### cURL: tracking.setup (Direct GA4/Meta mode)

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command":"tracking.setup",
    "input":{
      "siteId":"site_uuid",
      "mode":"direct",
      "domain":"www.example.com",
      "ga4MeasurementId":"G-PSW1MY7HB4",
      "metaPixelId":"123456789012345"
    }
  }'
```

### cURL: goals.list

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"goals.list","input":{"siteId":"site_uuid"}}'
```

### cURL: goals.create

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"goals.create","input":{"siteId":"site_uuid","name":"Qualified Lead"}}'
```

### cURL: reports.contacts.list

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"reports.contacts.list","input":{"siteId":"site_uuid","page":1,"perPage":25}}'
```

### cURL: reports.contacts.detail

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"reports.contacts.detail","input":{"siteId":"site_uuid","contactId":"contact_uuid"}}'
```

### cURL: docs.list

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"docs.list","input":{"page":1,"perPage":20,"state":"published"}}'
```

### cURL: docs.search

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"docs.search","input":{"query":"connect domain","page":1,"perPage":10,"state":"published"}}'
```

### cURL: docs.get

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{"command":"docs.get","input":{"articleId":"15284583"}}'
```

## 14) Error Handling Contract

HTTP status guidance:

- `400`: invalid payload, missing required fields, invalid IDs/date ranges.
- `401`: invalid or missing key.
- `403`: blocked command, inaccessible scope, feature not enabled.
- `404`: resource not found.
- `429`: rate limit exceeded.
- `500`: unexpected server error.

Recommended retry policy:

- Retry `429` with backoff and jitter.
- Read `X-RateLimit-Reset` before retrying `429`; default limit is 60 requests per minute unless the key has a custom internal limit.
- Retry `500` up to 3 attempts.
- Do not retry `400`, `401`, `403`, `404` without correcting input or permissions.

## 15) Production Guardrails For Agent Builders

- Always keep a per-command audit log.
- Require human confirmation before status changes in production.
- Require human confirmation for domain operations.
- Use idempotency keys on your side for repeated workflows.
- Never store plaintext API keys in logs.

## 16) Final Checklist Before You Mark A Task Done

- Correct site selected?
- Required IDs resolved from list/read commands?
- Write operation succeeded with `200`?
- Read-back verification performed?
- Outcome summary posted for user?


## 17) Complete Payload Library (All Supported Commands)

Use these as copy-paste JSON payloads for `POST https://uxon.ai/api/external/commands`.

### Sub-accounts

#### `subaccounts.list`

```json
{
  "command": "subaccounts.list",
  "input": {}
}
```

#### `subaccounts.get`

```json
{
  "command": "subaccounts.get",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `subaccounts.create`

```json
{
  "command": "subaccounts.create",
  "input": {
    "name": "ACME Dental",
    "websiteUrl": "https://acmedental.com",
    "reportingCurrency": "USD",
    "reportingTimezone": "Australia/Brisbane",
    "landingPageFeedbackMode": "free_comments"
  }
}
```

#### `subaccounts.update`

```json
{
  "command": "subaccounts.update",
  "input": {
    "siteId": "site_uuid",
    "name": "ACME Dental Group",
    "websiteUrl": "https://www.acmedental.com",
    "reportingCurrency": "AUD",
    "reportingTimezone": "Australia/Brisbane",
    "landingPageFeedbackMode": "ai_approvals"
  }
}
```

### Landing pages

#### `landing_pages.list`

```json
{
  "command": "landing_pages.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `landing_pages.create`

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
      "links": [
        {
          "label": "Campaign brief",
          "url": "https://example.com/brief"
        }
      ],
      "raw": {}
    }
  }
}
```

#### `landing_pages.generate_from_brief`

```json
{
  "command": "landing_pages.generate_from_brief",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer",
    "brief": {
      "brandName": "ACME Dental",
      "websiteUrl": "https://www.acmedental.com",
      "language": "English (US)",
      "funnelStrategy": "Service",
      "buyerGroup": "Consumers (B2C)",
      "desiredAction": "Submit a form",
      "market": "Brisbane, Queensland",
      "serviceOrProduct": "Emergency dental appointments for new patients",
      "idealClient": "Adults with urgent dental pain who need a same-day appointment"
    }
  }
}
```

#### `landing_pages.generation_status`

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

```json
{
  "command": "landing_pages.update",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "landing_page_uuid",
    "name": "Spring Offer Rev 2",
    "settings": {
      "publish": {
        "domain": "www.example.com",
        "path": "/spring-offer",
        "hideFromSearch": true
      }
    },
    "knowledgeBase": {
      "summary": "Updated page context for new visitors.",
      "notes": ["Keep the offer focused on fast appointment booking."],
      "links": [],
      "raw": {}
    }
  }
}
```

#### `landing_pages.code_variant.upload`

```json
{
  "command": "landing_pages.code_variant.upload",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "landing_page_uuid",
    "variantName": "External Code Variant",
    "zipUrl": "https://example.com/builds/landing-page.zip",
    "makeMain": false,
    "publish": false
  }
}
```

#### `landing_pages.set_status`

```json
{
  "command": "landing_pages.set_status",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "landing_page_uuid",
    "status": "live"
  }
}
```

#### `reports.landing_pages.summary`

```json
{
  "command": "reports.landing_pages.summary",
  "input": {
    "siteId": "site_uuid",
    "from": "2026-03-20T00:00:00.000Z",
    "to": "2026-04-19T23:59:59.999Z"
  }
}
```

#### `reports.landing_page.details`

```json
{
  "command": "reports.landing_page.details",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "landing_page_uuid",
    "from": "2026-03-20T00:00:00.000Z",
    "to": "2026-04-19T23:59:59.999Z"
  }
}
```

#### `reports.landing_page.variant_metrics`

```json
{
  "command": "reports.landing_page.variant_metrics",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "landing_page_uuid",
    "from": "2026-03-20T00:00:00.000Z",
    "to": "2026-04-19T23:59:59.999Z"
  }
}
```

#### `reports.landing_page.trends`

```json
{
  "command": "reports.landing_page.trends",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "landing_page_uuid",
    "from": "2026-03-20T00:00:00.000Z",
    "to": "2026-04-19T23:59:59.999Z",
    "granularity": "day",
    "metric": "sessions"
  }
}
```

#### `reports.landing_page.channels`

```json
{
  "command": "reports.landing_page.channels",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "landing_page_uuid",
    "dateRange": "last-30-days"
  }
}
```

### Experiments

#### `experiments.list`

```json
{
  "command": "experiments.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `experiments.get`

```json
{
  "command": "experiments.get",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "experiment_uuid"
  }
}
```

#### `experiments.create` (UXON vs UXON)

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
    "controlLandingPage": "control_landing_page_uuid",
    "controlVariant": "control_variant_uuid",
    "variantSource": "uxon",
    "variantLandingPage": "variant_landing_page_uuid",
    "variantVariant": "variant_variant_uuid",
    "testTrigger": "entry",
    "visitorType": "all-visitors",
    "deviceType": "all-devices",
    "trafficAllocation": 100
  }
}
```

#### `experiments.create` (External vs External)

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
    "testTrigger": "entry",
    "visitorType": "all-visitors",
    "deviceType": "all-devices",
    "trafficAllocation": 100
  }
}
```

#### `experiments.create` (URL Pattern to External)

```json
{
  "command": "experiments.create",
  "input": {
    "siteId": "site_uuid",
    "nickname": "Pricing URL Pattern Test",
    "selectedGoals": [
      { "id": "lead_goal_uuid", "name": "Lead" },
      { "id": "call_goal_uuid", "name": "Phone call" }
    ],
    "controlSource": "url_patterns",
    "variantSource": "external",
    "variantPageUrl": "https://www.example.com/pricing-variant",
    "urlPatterns": {
      "side": "control",
      "conditions": [
        { "type": "include", "operator": "contains", "value": "/pricing" },
        { "type": "exclude", "operator": "contains", "value": "/thank-you" }
      ]
    },
    "geoFilters": {
      "countries": {
        "type": "include",
        "countryCodes": ["US", "CA"],
        "includeUnknown": false
      }
    },
    "testTrigger": "entry",
    "visitorType": "all-visitors",
    "deviceType": "all-devices",
    "trafficAllocation": 100
  }
}
```

#### `experiments.update`

```json
{
  "command": "experiments.update",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "experiment_uuid",
    "nickname": "Headline Test Rev 2",
    "hypothesis": "Benefit-led headline increases lead conversion.",
    "testTrigger": "visits",
    "trafficAllocation": 75,
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

```json
{
  "command": "experiments.set_status",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "experiment_uuid",
    "status": "Running"
  }
}
```

#### `reports.experiments.summary`

```json
{
  "command": "reports.experiments.summary",
  "input": {
    "siteId": "site_uuid",
    "from": "2026-03-20T00:00:00.000Z",
    "to": "2026-04-19T23:59:59.999Z"
  }
}
```

#### `reports.experiment.details`

```json
{
  "command": "reports.experiment.details",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "experiment_uuid",
    "from": "2026-03-20T00:00:00.000Z",
    "to": "2026-04-19T23:59:59.999Z",
    "timezone": "Australia/Brisbane",
    "conversionGoalId": "all"
  }
}
```

#### `reports.experiment.chart`

```json
{
  "command": "reports.experiment.chart",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "experiment_uuid",
    "dateRange": "last-30-days",
    "timezone": "Australia/Brisbane",
    "conversionGoalId": "lead_goal_uuid"
  }
}
```

#### `reports.experiment.channels`

```json
{
  "command": "reports.experiment.channels",
  "input": {
    "siteId": "site_uuid",
    "experimentId": "experiment_uuid",
    "dateRange": "last-30-days",
    "timezone": "Australia/Brisbane",
    "conversionGoalId": "all"
  }
}
```

### Domains

#### `domains.list`

```json
{
  "command": "domains.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

#### `domains.add`

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

```json
{
  "command": "domains.connect",
  "input": {
    "domainId": "domain_uuid"
  }
}
```

### Tracking

#### `tracking.setup`

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

### Goals

#### `goals.list`

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

#### `goals.create`

```json
{
  "command": "goals.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Qualified Lead",
    "isActive": true,
    "googleAdsConversionId": null,
    "googleAdsConversionLabel": null,
    "googleAdsEnabled": false
  }
}
```

#### `goals.update`

```json
{
  "command": "goals.update",
  "input": {
    "siteId": "site_uuid",
    "goalId": "goal_uuid",
    "isActive": true,
    "googleAdsEnabled": true
  }
}
```

### Contacts

#### `reports.contacts.list`

```json
{
  "command": "reports.contacts.list",
  "input": {
    "siteId": "site_uuid",
    "page": 1,
    "perPage": 25,
    "search": "john",
    "landingPageId": "landing_page_uuid",
    "startDate": "2026-03-20T00:00:00.000Z",
    "endDate": "2026-04-19T23:59:59.999Z"
  }
}
```

#### `reports.contacts.detail`

```json
{
  "command": "reports.contacts.detail",
  "input": {
    "siteId": "site_uuid",
    "contactId": "contact_uuid"
  }
}
```

### Knowledge base articles

#### `docs.list`

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

```json
{
  "command": "docs.search",
  "input": {
    "query": "connect domain",
    "page": 1,
    "perPage": 10,
    "state": "published"
  }
}
```

#### `docs.get`

```json
{
  "command": "docs.get",
  "input": {
    "articleId": "15284583"
  }
}
```

## 18) Experiment Launch Checklist (No Guesswork)

Use this exact process when creating real experiments.

1. Resolve the site: run `subaccounts.list` and capture `subaccounts[].id` as `siteId`.
2. Resolve goals: run `goals.list` and choose valid goal IDs for `selectedGoals`.
3. Resolve landing page IDs: run `landing_pages.list` and capture landing page IDs.
4. Resolve variant IDs: run `reports.landing_page.details` for each selected landing page and capture `landingPage.variants[].id`.
5. Build create payload:
   - For UXON target, pass landing page ID + variant ID.
   - For external target, pass URL field.
   - For URL Pattern target, pass `urlPatterns` on exactly one side.
6. Create draft: run `experiments.create`.
7. Confirm setup: run `experiments.get` and check sources, selected goals, targeting, filters, and `preserveRedirectParams`.
8. Launch: run `experiments.set_status` with `status = "Running"`.
9. Verify results: run `reports.experiment.details` and `reports.experiment.chart`; use `conversionGoalId` only when reporting one selected goal.

Required field matrix for `experiments.create`:

- Always required:
  - `siteId`
  - `nickname`
  - `selectedGoals` for new integrations
  - legacy fallback: one of `goalId` or `goal`
- Control side:
  - if `controlSource = "uxon"` -> `controlLandingPage` and `controlVariant`
  - if `controlSource = "external"` -> `controlPageUrl`
  - if `controlSource = "url_patterns"` -> `urlPatterns.side = "control"`
- Variant side:
  - if `variantSource = "uxon"` -> `variantLandingPage` and `variantVariant`
  - if `variantSource = "external"` -> `variantPageUrl`
  - if `variantSource = "url_patterns"` -> `urlPatterns.side = "variant"`

Experiment setup rules:

- Use `selectedGoals` for one or more conversion goals.
- Do not combine Bounce with any other goal.
- URL Patterns can be selected by Control or Variant, not both.
- URL Patterns require at least one Include URLs condition and support up to 5 total conditions.
- Traffic filters are exact stored tracking key matches, not operator-based rules.
- Geo filters use `geoFilters.countries.type`, `countryCodes`, and `includeUnknown`.
- `preserveRedirectParams` defaults to `true` and keeps source query parameters on experiment redirects.

Status value rules:

- Landing pages: `draft` or `live` (lowercase)
- Experiments: `Draft`, `Running`, `Paused`, `Ended` (title case)

## 19) Error Message To Action Map

These are real server-side messages and the correct fix path.

### Access and scope

- `API Keys access is available on Advance and Enterprise plans.`
  - Upgrade the plan to Advance or Enterprise.
- `API Keys access is disabled for this enterprise account. Ask your admin to enable it in Operations settings.`
  - Enterprise admin must enable Operations -> API Keys in superadmin.
- `This API key is restricted to a different site.`
  - Use the key's allowed site or use an unrestricted/team-level key.
- `Requested siteId is not part of this team.`
  - Resolve valid site IDs from `subaccounts.list`.

### General validation

- `Invalid command payload`
  - Ensure JSON is valid and includes `command` and `input`.
- `Invalid input for <command>...`
  - Fix fields exactly as described in this playbook.
- `siteId is required for this command.`
  - Include `siteId` unless command is `domains.connect`.
- `Invalid from.` / `Invalid to.` / `Invalid startDate.` / `Invalid endDate.`
  - Use ISO date strings.
- `Invalid date range.`
  - Ensure from <= to, or use a supported `dateRange` token.

### ID resolution

- `landingPageId is required.`
  - Provide `landingPageId` or `id`.
- `experimentId is required.`
  - Provide `experimentId` or `id`.
- `goalId is required.`
  - Provide `goalId` or `id`.
- `contactId is required.`
  - Provide `contactId` or `id`.
- `domainId is required.`
  - Provide `domainId` (for `domains.connect`).

### Resource not found

- `Sub-account not found.`
- `Landing page not found.`
- `Experiment not found.`
- `Domain not found.`
- `Goal not found.`
- `Contact not found.`
- `Site not found.`

Action for all not-found errors:

- Re-resolve IDs using list/read commands and retry with exact UUID.

### Write safety and lifecycle rules

- `Use landing_pages.set_status for status changes.`
  - Do not send `status` to `landing_pages.update`.
- `Use experiments.set_status for status changes.`
  - Do not send `status` to `experiments.update`.
- `No fields provided to update.`
  - Send at least one mutable field.

### Landing page publish validations

- `A connected domain and URL path are required to publish.`
  - Provide complete publish settings before setting status to `live`.
- `Selected domain must belong to this workspace and be connected.`
  - Attach/connect domain for the same site first.
- `This domain and path are already used by another page.`
  - Choose a unique domain/path pair.
- `Please create a variant before publishing.`
  - Ensure page has at least one variant.
- `Unable to determine the main variant.`
  - Recreate variants and retry publish.
- `Provide exactly one of zipBase64 or zipUrl`
  - Send either inline base64 ZIP content or an HTTPS ZIP URL, not both.
- `Format not accepted. Include index.html at the root of the ZIP.`
  - Upload built static output with `index.html` and referenced assets included.
- `ZIP is too large. Please upload a bundle under 250MB.`
  - Keep custom code page ZIPs under 250MB.
- `Upgrade required: Custom code pages are not included in your current plan.`
  - Upgrade plan or use a normal UXON builder variant.

### Experiment setup validations

- `nickname is required.`
  - Provide non-empty nickname.
- `Selected goal not found.`
  - Use valid goal IDs from `goals.list`, preferably in `selectedGoals`.
- `selectedGoals or goalId or goal is required.`
  - Send `selectedGoals` for new integrations, or legacy `goalId` / `goal`.
- `Bounce cannot be combined with another goal.`
  - Use Bounce by itself or choose non-Bounce conversion goals.
- `controlPageUrl is required for external control source.`
  - Add URL when control source is external.
- `controlLandingPage and controlVariant are required.`
  - Add both IDs when control source is UXON.
- `variantPageUrl is required for external variant source.`
  - Add URL when variant source is external.
- `variantLandingPage and variantVariant are required.`
  - Add both IDs when variant source is UXON.
- `URL Patterns can be selected on Control or Variant, not both.`
  - Use `url_patterns` on only one side.
- `Add URL Pattern conditions.`
  - Add `urlPatterns.side` and at least one Include URLs condition.
- `URL Pattern side does not match the selected target.`
  - If Control uses `url_patterns`, set `urlPatterns.side` to `control`; if Variant uses it, set it to `variant`.
- `URL Patterns support up to 5 conditions.`
  - Reduce total include/exclude URL conditions to 5 or fewer.
- `Selected conversion goal is not part of this experiment.`
  - Use `"all"` or one of the experiment's selected goal IDs for `conversionGoalId`.
- `Invalid Geo filter country condition.`
  - Use `include` or `exclude`.
- `Select at least one country to use Geo filters.`
  - Add country codes or clear `geoFilters`.
- `External page sources are not included in your current plan.`
  - Upgrade plan or switch to UXON sources.
- `Traffic Filters are not included in your current plan.`
  - Remove `trafficFilters` or upgrade.
- `Geo filters are not included in your current plan.`
  - Remove `geoFilters` or upgrade.

### Goals-specific rules

- `System goals cannot update name or active status.`
  - Only custom goals can change name/active.
- `Only the Lead system goal can update Google Ads settings.`
  - Restrict Google Ads fields to the Lead system goal.
- `name is required.`
  - Goal/sub-account/landing page names cannot be blank.

### Domains

- `domain is required.`
  - Provide root domain.
- `Invalid domain or subdomain.`
  - Use valid host format.
- `This domain or subdomain has already been added.`
  - Use a different host or existing domain ID.
- `Failed to create domain.`
  - Retry later; verify domain service config.
- `Domain is missing SaaS reference UUID.`
  - Domain record is incomplete; recreate or repair it.

### Rate limiting and retries

- `Rate limit exceeded`
  - Default limit is 60 requests per minute unless the key has a custom internal limit.
  - Read `X-RateLimit-Reset`, wait, then retry.
- `Failed to process external command`
  - Treat as transient server error; retry with backoff.
