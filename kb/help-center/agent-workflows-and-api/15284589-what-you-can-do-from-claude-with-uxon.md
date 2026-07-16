# What you can do from Claude with UXON

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Practical tasks you can run in Claude using the UXON connector.
- After connecting UXON to Claude, you can run real CRO operations directly in chat instead of jumping between tools.
- Main capabilities in Claude **Account setup**: create and update client accounts.

## Source
- Help Center: [What you can do from Claude with UXON](https://docs.uxon.ai/en/articles/15284589-what-you-can-do-from-claude-with-uxon)
- Source collection: Agent workflows and API

## Related UXON Guides
- [Agent command playbook](../../../SKILLS.md)
- [Claude onboarding prompt](../../../examples/mcp/claude-onboarding-prompt.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)

## Article
After connecting UXON to Claude, you can run real CRO operations directly in chat instead of jumping between tools.

## Main capabilities in Claude

- **Account setup**: create and update client accounts.
- **Branding setup**: set brand fields and assets used by landing pages.
- **Domain setup**: generate domain instructions and check DNS status.
- **Landing page operations**: create pages, update content, and manage variants.
- **Reporting visibility**: request recent activity and performance summaries.

## Guided flows you can start in chat

1. **First client setup**: create client account, apply branding basics, and prepare domain setup.
2. **Reporting quick check**: ask for a short health summary for the last 24h, 7d, or 30d.
3. **Troubleshooting flow**: review connector activity and identify failed operations.

## Example prompts to use in Claude

- "Show my client accounts in UXON."
- "Create a new client account for [brand name]."
- "Help me set up branding for [brand name]."
- "Generate domain setup instructions for [client website]."
- "Give me a connector activity report for the last 7 days."

## Actions that require confirmation

For destructive or high-impact changes, UXON asks for explicit confirmation before applying changes.

## Current limits to know

- Your role and plan control what actions are available.
- Some operations can require follow-up checks (for example DNS propagation).
- If access is denied, use **Troubleshoot Claude connector issues**.

## Start with one command: First Client Setup Autopilot

If you want to move faster, ask Claude to run the first-client autopilot workflow. It will guide setup across client account, branding, tracking, and domain setup in one flow.

**Prompt example:** Start first client setup for Acme Solar with website https://acmesolar.com

- Claude will ask only missing details.
- Tracking guardrail is automatic: GTM and direct tags are not kept active together.
- If DNS is not ready yet, Claude will pause and tell you when to re-check.
