# Connect an external AI agent to UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Choose the right connection path: Claude connector (OAuth) or API key + live SKILLS page.
- You can connect UXON AI to external AI tools in two ways.
- For most teams, the Claude custom connector is the recommended path because each teammate signs in as themselves.

## Source
- Help Center: [Connect an external AI agent to UXON AI](https://docs.uxon.ai/en/articles/14729002-connect-an-external-ai-agent-to-uxon-ai)
- Source collection: Agent workflows and API

## Related UXON Guides
- [Agent command playbook](../../../SKILLS.md)
- [Claude onboarding prompt](../../../examples/mcp/claude-onboarding-prompt.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)

## Article
You can connect UXON AI to external AI tools in two ways. For most teams, the Claude custom connector is the recommended path because each teammate signs in as themselves.

## Choose your connection path

| Path | Best for | How auth works |
| --- | --- | --- |
| **Claude connector (OAuth)** | Day-to-day team usage in chat | Each user signs in with their UXON account |
| **API key + live SKILLS page** | Advanced automation and custom agent setups | Shared API key managed by your team |

## Path A: Claude connector (recommended)

1. Open Claude, go to [Add custom connector](https://claude.ai/customize/connectors?modal=add-custom-connector), and set Remote MCP server URL to **https://uxon.ai/api/mcp**.
2. Select **Connect** and sign in to UXON AI.
3. Approve access, then return to Claude.
4. Run a first command like: **Show my client accounts**.

## Path B: API key + live SKILLS page

1. Generate or copy a UXON API key from Account settings.
2. Load the API key into your external agent environment.
3. Open [https://uxon.ai/api/skills](https://uxon.ai/api/skills) for the live command playbook, then use the listed commands with your bearer API key.

## What you can do after connecting

- Create and manage client accounts and landing pages
- Read reporting and performance summaries
- Set up domains, branding, and workflow-driven onboarding tasks

## Troubleshooting

**Connector access denied during sign-in.**

- Your account may not have connector access active yet. Contact UXON support to confirm account access.
- You may be on a plan or role without connector access.
- Use the troubleshooting article for exact fixes: **Troubleshoot Claude connector issues**.

**API key commands fail with auth errors.**

- Check that the API key is valid and active.
- Confirm the key has access to the target workspace.
