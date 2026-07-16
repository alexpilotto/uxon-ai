# Team permissions for connector operations (owner/admin/member)

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- See which team roles can view connector metrics, export reports, and revoke sessions.
- Connector operations in UXON are role-controlled.
- This protects your team from unauthorized high-impact actions.

## Source
- Help Center: [Team permissions for connector operations (owner/admin/member)](https://docs.uxon.ai/en/articles/15284591-team-permissions-for-connector-operations-owner-admin-member)
- Source collection: Agent workflows and API

## Related UXON Guides
- [Agent command playbook](../../../SKILLS.md)
- [Claude onboarding prompt](../../../examples/mcp/claude-onboarding-prompt.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)

## Article
Connector operations in UXON are role-controlled. This protects your team from unauthorized high-impact actions.

## Permission matrix

| Operation | Owner | Admin | Member |
| --- | --- | --- | --- |
| View MCP connector metrics | Yes | Yes | No |
| Export connector activity CSV | Yes | Yes | No |
| Revoke all connector OAuth sessions | Yes | Yes | No |

## Why these actions are restricted

- Metrics and exports can expose operational activity data.
- Revoke-all immediately disconnects all active connector sessions for the team.

## If a member needs access

1. Ask an owner/admin to run the action.
2. If your process requires direct access, ask a team owner to update your role.

## Troubleshooting permission errors

**You receive Forbidden when opening connector operations.**

- Your role is likely **member**.
- Confirm your role with a team owner/admin.
