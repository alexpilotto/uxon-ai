# UXON Runbooks

UXON runbooks are step-by-step workflows for AI agents and operators who manage landing pages, A/B tests, tracking, and reporting across client accounts.

Each runbook assumes the agent has access to UXON through the API command endpoint or Claude MCP connector.

## Runbook Index

- [Onboard a new client](onboard-new-client.md)
- [Launch an A/B test](launch-ab-test.md)
- [Run a cross-domain experiment](cross-domain-experiment.md)
- [Morning account check](morning-account-check.md)
- [Weekly optimization cycle](weekly-optimization.md)

## Shared Safety Rules

- Resolve IDs before write commands.
- Confirm before publishing pages.
- Confirm before starting, pausing, or ending experiments.
- Confirm before changing tracking or domains.
- Read back changed resources after write commands.
- Use reports to close the loop after traffic starts.
