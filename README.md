# UXON AI

UXON is an MCP server and API for creating landing pages, running A/B experiments, and tracking conversions across domains.

Developers and AI agents use UXON to manage the post-click marketing workflow: programmatic landing page creation, custom code page imports, cross-domain A/B testing, first-party attribution, conversion reporting, and repeatable agency operations through one API and MCP connector.

UXON supports Claude connector workflows, API-key automation, and external agents that need controlled access to marketing execution tasks.

## What UXON Does

- Create and publish landing pages through API commands or guided agent workflows.
- Import externally coded landing page bundles from Claude Code, Codex, Cursor, v0, or custom build systems.
- Launch A/B experiments across UXON pages, external URLs, or URL-pattern targets.
- Track conversions with first-party attribution across pages, variants, channels, contacts, and revenue events.
- Configure tracking through GTM or direct GA4/Meta setup with duplicate-loading guardrails.
- Pull CRO reports from agents, automations, dashboards, and recurring workflows.
- Onboard agency client accounts with branding, tracking, domain, and reporting setup.

## Repository Scope

This repository is public technical documentation for UXON. It contains command references, examples, runbooks, and agent workflow guidance.

This repository does not contain the private UXON application source code. UXON runs as a hosted platform at [uxon.ai](https://uxon.ai).

## Quick Start

Use the hosted UXON API command endpoint:

```text
POST https://uxon.ai/api/external/commands
```

Send commands with a UXON API key:

```bash
curl -X POST 'https://uxon.ai/api/external/commands' \
  -H 'Authorization: Bearer uxon_live_REPLACE_WITH_REAL_KEY' \
  -H 'Content-Type: application/json' \
  -d '{
    "command": "subaccounts.list",
    "input": {}
  }'
```

For Claude connector users, use the MCP endpoint:

```text
https://uxon.ai/api/mcp
```

See [QUICKSTART.md](QUICKSTART.md) for the short setup path.

## Core Concepts

- [What is UXON?](docs/what-is-uxon.md)
- [Frequently asked questions](docs/faq.md)
- [Agent command playbook](SKILLS.md)

## Capability Guides

The [skills](skills/README.md) folder splits the command surface by capability so developers and AI agents can retrieve the exact area they need:

- [Landing pages](skills/landing-pages.md)
- [Experiments](skills/experiments.md)
- [Conversion tracking](skills/conversion-tracking.md)
- [Domains](skills/domains.md)
- [Goals](skills/goals.md)
- [Reports](skills/reports.md)
- [Contacts](skills/contacts.md)
- [Knowledge base articles](skills/knowledge-base.md)

## Common API Commands

All API-key commands use this envelope:

```json
{
  "command": "landing_pages.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer"
  }
}
```

High-value command families include:

- `landing_pages.*` for page creation, updates, publishing, and custom code uploads.
- `experiments.*` for draft creation, updates, lifecycle changes, and cross-domain testing.
- `reports.*` for landing page, experiment, channel, trend, contact, and revenue reporting.
- `tracking.setup` for GTM or direct GA4/Meta setup.
- `goals.*` for conversion goal management.
- `domains.*` for connected domain workflows.
- `docs.*` for Help Center article search and retrieval.

## Agent Workflows

UXON is designed for governed agent execution. Agents should:

1. Resolve account and resource IDs before writes.
2. Send minimal payloads.
3. Keep high-impact actions confirmable.
4. Read back changed resources after write commands.
5. Use reporting commands to close the loop after traffic starts.

Example Claude prompt:

```text
Start first client setup for Acme Dental, website https://acmedental.com.
```

The guided onboarding workflow collects missing inputs, prepares setup steps, and keeps domain and tracking work inside a controlled UXON flow.

## Runbooks And Examples

Use the [runbooks](runbooks/README.md) for repeatable operating workflows:

- [Onboard a new client](runbooks/onboard-new-client.md)
- [Launch an A/B test](runbooks/launch-ab-test.md)
- [Run a cross-domain experiment](runbooks/cross-domain-experiment.md)
- [Morning account check](runbooks/morning-account-check.md)
- [Weekly optimization cycle](runbooks/weekly-optimization.md)

Use the [examples](examples) folder for copy-paste starting points:

- [Create a landing page with cURL](examples/curl/create-landing-page.sh)
- [Launch an experiment with cURL](examples/curl/launch-experiment.sh)
- [Set up tracking with cURL](examples/curl/setup-tracking.sh)
- [Pull an experiment report with cURL](examples/curl/pull-report.sh)
- [Claude onboarding prompt](examples/mcp/claude-onboarding-prompt.md)
- [Claude weekly check prompt](examples/mcp/claude-weekly-check.md)

## Knowledge Base

The [knowledge base](kb/README.md) mirrors UXON Help Center guidance in public Markdown:

- [Connect an external AI agent to UXON](kb/agent-workflows/connect-external-ai-agent.md)
- [Import code pages with a ZIP file](kb/landing-pages/import-code-pages.md)
- [Set up external-page experiments](kb/experiments/external-page-experiments.md)
- [Connect a custom domain](kb/domains/connect-custom-domain.md)
- [Set up enhanced conversions with GTM](kb/tracking/enhanced-conversions-gtm.md)
- [Read CRO performance reports from an agent](kb/reporting/read-cro-performance-reports.md)
- [Full published Help Center export](kb/help-center/README.md)

## Documentation Roadmap

This repository is being built in layers:

1. Root README, quickstart, and public-safe agent playbook.
2. Capability-specific command pages.
3. Agency runbooks and copy-paste examples.
4. Curated knowledge-base articles.
5. Full published Help Center export with source collection structure.

## Links

- UXON website: [https://uxon.ai](https://uxon.ai)
- MCP endpoint: `https://uxon.ai/api/mcp`
- API command endpoint: `https://uxon.ai/api/external/commands`
