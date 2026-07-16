# Connect UXON to Claude (custom connector)

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Set up the UXON connector in Claude and complete OAuth sign-in successfully.
- This guide shows how to connect UXON AI to Claude using the custom connector flow.
- Before you start You need an active UXON account.

## Source
- Help Center: [Connect UXON to Claude (custom connector)](https://docs.uxon.ai/en/articles/15284583-connect-uxon-to-claude-custom-connector)
- Source collection: Agent workflows and API

## Related UXON Guides
- [Agent command playbook](../../../SKILLS.md)
- [Claude onboarding prompt](../../../examples/mcp/claude-onboarding-prompt.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)

## Article
This guide shows how to connect UXON AI to Claude using the custom connector flow.

## Before you start

- You need an active UXON account.
- Your team needs connector access enabled.
- You should know your UXON login credentials.

## Connect UXON in Claude

1. In Claude, open [Add custom connector](https://claude.ai/customize/connectors?modal=add-custom-connector) and set Remote MCP server URL to **https://uxon.ai/api/mcp**.
2. Select **Connect**.
3. You are redirected to UXON sign-in. Log in as yourself.
4. Approve connector access.
5. Return to Claude and wait for connector status to show **Connected**.

## Run a first success check

In Claude, ask:

- **Show my client accounts in UXON**
- **What can I do with UXON from here?**

If Claude returns UXON data, the connection is complete.

## Why connector access can be denied (and how to fix it)

| Cause | What to do |
| --- | --- |
| Connector access not active for account | Ask UXON support to confirm connector access is active for your account. |
| Wrong account signed in | Sign out and reconnect using the intended UXON user account. |
| Insufficient plan/role access | Confirm your subscription and team role permissions. |
| Stale connector session | Disconnect and reconnect; if needed, ask admin to revoke sessions. |

## What happens next

After connection, Claude can guide onboarding tasks such as setting up your first client account, branding, and domain setup directly in chat.

## Troubleshooting

**Claude says connector connected but commands fail.**

- Reconnect once to refresh OAuth tokens.
- Retry with a simple read request first (for example list client accounts).

**I still cannot connect.**

- Use the dedicated troubleshooting article: **Troubleshoot Claude connector issues**.
