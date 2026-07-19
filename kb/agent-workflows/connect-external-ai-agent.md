# Connect An External AI Agent To UXON

UXON supports external AI agents through two connection paths: Claude connector over MCP and API key commands using the live `SKILLS.md` playbook. Claude connector is best for OAuth-based chat workflows where each teammate signs in as themselves. API keys are best for advanced automation, custom agents, scheduled jobs, and internal tools.

Source Help Center article: [Connect an external AI agent to UXON AI](https://docs.uxon.ai/en/articles/14729002-connect-an-external-ai-agent-to-uxon-ai)

## Connection Paths

| Path | Best For | Auth Model |
| --- | --- | --- |
| Claude connector | Day-to-day team usage in chat | Each user signs in with UXON OAuth |
| API key + live `SKILLS.md` page | Advanced automation and custom agents | Shared team-managed API key |

## Claude Connector Flow

1. Add the UXON MCP connector URL in Claude.
2. Select connect and sign in to UXON.
3. Approve connector access.
4. Return to Claude and run a read command such as `Show my client accounts`.

MCP endpoint:

```text
https://uxon.ai/api/mcp
```

## API Key Flow

1. Generate a UXON API key from account settings.
2. Load the key into the external agent environment.
3. Use the [latest live SKILLS page](https://uxon.ai/api/skills) as the current Claude skill / agent command playbook.

API endpoint:

```text
POST https://uxon.ai/api/external/commands
```

## What Agents Can Do

Connected agents can create and manage client accounts, create landing pages, read reports, configure domains, support tracking setup, and run guided workflows when the account has access.

## Related Files

- [Quickstart](../../QUICKSTART.md)
- [Agent command playbook](../../SKILLS.md)
- [Knowledge base API](../../skills/knowledge-base.md)
