# Troubleshoot Claude connector issues

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Fix common UXON connector problems in Claude, including access denied and activity report export.
- Use this guide when the UXON connector in Claude fails to connect, returns errors, or behaves inconsistently.
- Open Add custom connector and confirm Remote MCP server URL is **https://uxon.ai/api/mcp**.

## Source
- Help Center: [Troubleshoot Claude connector issues](https://docs.uxon.ai/en/articles/15284584-troubleshoot-claude-connector-issues)
- Source collection: Agent workflows and API

## Related UXON Guides
- [Agent command playbook](../../../SKILLS.md)
- [Claude onboarding prompt](../../../examples/mcp/claude-onboarding-prompt.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)

## Article
Use this guide when the UXON connector in Claude fails to connect, returns errors, or behaves inconsistently.

## Fast checks (1 minute)

1. Open [Add custom connector](https://claude.ai/customize/connectors?modal=add-custom-connector) and confirm Remote MCP server URL is **https://uxon.ai/api/mcp**.
2. Confirm you are logged in to the correct UXON account.
3. Reconnect the UXON connector once in Claude.
4. Run a simple read request (for example: **Show my client accounts**).

## Why connector access can be denied (and how to fix it)

| Error reason | Fix |
| --- | --- |
| Connector access not active for account | Contact UXON support and request connector access verification for your account. |
| Plan does not include connector access | Upgrade or ask your account owner to confirm plan eligibility. |
| Role lacks required permission | Ask a team owner/admin to review your role access. |
| Session revoked or expired | Reconnect the connector to create a fresh OAuth session. |

## Common issues and fixes

**Connected, but Claude cannot run UXON actions.**

- Reconnect the connector and retry.
- Try a read action first, then your write action.

**Claude actions time out or fail intermittently.**

- Retry once; transient failures can occur.
- If repeated, export activity report and share with support.

## Export connector activity report (24h / 7d / 30d)

1. In UXON, go to **Account** -> **API**.
2. Open **MCP connector operations**.
3. Choose window: **24h**, **7d**, or **30d**.
4. Select **Export CSV**.

Share that CSV with UXON support to speed up troubleshooting.

## Emergency: revoke all connector sessions

If you suspect compromised access, a team owner/admin can revoke all active connector OAuth sessions from the same **MCP connector operations** panel in Account API settings.

## When to contact support

Contact UXON support if the problem persists after reconnecting and exporting a report. Include your team name, approximate time, and the exported CSV.
