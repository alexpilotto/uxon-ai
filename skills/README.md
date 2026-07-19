# UXON Claude Skill Guides

UXON skill guides split the public API and MCP command surface by capability so Claude, Claude Code, developers, and AI agents can retrieve the exact workflow they need.

Use these files alongside the root [SKILLS.md](../SKILLS.md), which contains the full public Claude skill / agent command playbook.

## Capability Index

- [Landing pages](landing-pages.md): create blank pages, submit AI briefs, poll generation, manage variants, publish pages, upload custom code variants, and read page reports.
- [Experiments](experiments.md): create, inspect, update, launch, pause, and report on A/B tests across UXON pages, external URLs, and URL-pattern targets.
- [Conversion tracking](conversion-tracking.md): configure GTM or direct GA4/Meta setup with duplicate-loading guardrails.
- [Domains](domains.md): list, add, and connect domains for landing page publishing and tracking.
- [Goals](goals.md): list, create, and update conversion goals for reporting and experiments.
- [Reports](reports.md): pull landing page, experiment, channel, trend, contact, and revenue performance.
- [Contacts](contacts.md): retrieve contact records and source context.
- [Knowledge base](knowledge-base.md): search and fetch UXON Help Center articles from agents.

## Agent Rule

Resolve IDs before write commands. Most UXON write commands need `siteId`, and experiments often need landing page variant IDs from `reports.landing_page.details`.
