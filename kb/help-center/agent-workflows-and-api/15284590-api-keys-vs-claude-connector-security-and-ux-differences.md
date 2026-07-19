# API keys vs Claude connector: security and UX differences

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Understand which access model fits your team and why most teams should use the connector.
- UXON supports two access models: API keys and the Claude connector.
- They both work, but they behave differently for security and daily workflow.

## Source
- Help Center: [API keys vs Claude connector: security and UX differences](https://docs.uxon.ai/en/articles/15284590-api-keys-vs-claude-connector-security-and-ux-differences)
- Source collection: Agent workflows and API

## Related UXON Guides
- [Agent command playbook](../../../SKILLS.md)
- [Claude onboarding prompt](../../../examples/mcp/claude-onboarding-prompt.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)

## Article
UXON supports two access models: API keys and the Claude connector. They both work, but they behave differently for security and daily workflow.

## Quick comparison

| Area | Claude connector (OAuth) | API key + live SKILLS page |
| --- | --- | --- |
| Who is acting | Named user account | Whoever has the key |
| Access control | Role-based per user | Key scope and storage controls |
| Revocation | Revoke connector sessions quickly | Rotate/revoke keys manually |
| Typical use | Team chat operations | Automation scripts and custom agents |

## Security in practical terms

- **Connector:** better traceability because actions are linked to a person.
- **API key:** more flexible for systems, but key leakage risk is higher if not managed carefully.

## User experience in practical terms

- **Connector:** easier for non-technical users; connect once and chat.
- **API key:** better for technical teams that need scripted or backend integrations.

## Which should you use?

- Use **Claude connector** for daily human-in-the-loop work.
- Keep **API keys** for automation and advanced external-agent workflows.
- Many teams use both: connector for people, keys for systems.
