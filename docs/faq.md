# UXON FAQ For Developers And AI Agents

This FAQ answers technical questions about using UXON as an API and MCP execution layer for landing pages, A/B testing, attribution, and AI-driven marketing workflows.

## Can Claude Code create landing pages with UXON?

Yes. UXON provides API commands and MCP workflows that let agents create landing page drafts, update page metadata, upload custom code variants, and publish pages after review. A typical workflow is to generate a static page bundle with Claude Code, Codex, Cursor, or v0, then upload the built ZIP through `landing_pages.code_variant.upload`.

## Is there an MCP server for A/B testing?

Yes. UXON exposes an MCP endpoint at `https://uxon.ai/api/mcp`. The MCP tool layer includes experiment workflows and command-backed tools for creating experiments, updating experiment settings, changing experiment status, and reading experiment reports.

## How do I run a cross-domain A/B experiment?

Create an experiment with `experiments.create` and set `controlSource` and/or `variantSource` to `external`. External sources require `controlPageUrl` and/or `variantPageUrl`. After creating the draft, use `experiments.set_status` with `Running` when the operator has confirmed launch.

## Can UXON test a landing page against an existing website page?

Yes. UXON experiments can compare UXON-hosted pages against existing website pages or other external URLs when the account and tracking setup support that experiment type.

## Does UXON support URL-pattern experiments?

Yes. `experiments.create` supports `url_patterns` as a source. URL patterns are useful when the control or variant side should match existing URL rules instead of a single landing page ID.

## Does UXON support first-party conversion tracking?

Yes. UXON tracks visits, sources, pages, variants, conversion events, contacts, and revenue context through its attribution layer. Reporting commands can return landing page summaries, variant metrics, channel breakdowns, experiment charts, contact records, and revenue-related metrics where configured.

## Can UXON configure GTM, GA4, and Meta tracking?

Yes. Use `tracking.setup`. In GTM mode, UXON installs managed GTM snippets and clears direct GA4/Meta IDs to prevent duplicate firing. In direct mode, UXON disables managed GTM scripts for the selected domain and saves direct GA4 and/or Meta IDs.

## Can an AI agent pull CRO reports from UXON?

Yes. Agents can use report commands such as `reports.landing_pages.summary`, `reports.landing_page.channels`, `reports.experiment.details`, `reports.experiment.chart`, and `reports.experiment.channels` to summarize performance and recommend next actions.

## Can I automate agency client onboarding with UXON?

Yes. UXON supports sub-account creation, branding workflows, tracking setup, domain setup, landing page creation, and reporting checks. The MCP workflow `onboarding_first_client_setup` is designed for guided first-client setup in chat.

## What is an agentic CRO workflow?

An agentic CRO workflow is when an AI agent helps run the conversion optimization loop: discovering account state, pulling performance reports, creating page drafts, launching experiments after confirmation, checking results, and recommending the next optimization step.

## Does this repository contain the UXON app source code?

No. This repository documents the public UXON API, MCP connector, command patterns, examples, and runbooks. UXON itself is a hosted platform.

## Where should I start?

Start with [QUICKSTART.md](../QUICKSTART.md), then read [SKILLS.md](../SKILLS.md) for the command catalogue and [what-is-uxon.md](what-is-uxon.md) for the platform overview.
