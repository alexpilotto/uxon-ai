# Claude Prompt: First Client Setup

Use this prompt after connecting Claude to UXON through the MCP connector.

```text
Start first client setup for Acme Dental, website https://acmedental.com.

Use USD as the reporting currency unless UXON asks for a better default.
Use the browser/client timezone if available; otherwise continue without adding timezone friction.
Use AI approvals for landing page feedback.
Ask me before publishing pages, starting experiments, changing tracking, or connecting domains.
```

Expected behavior:

- Claude starts the `onboarding_first_client_setup` workflow.
- UXON asks only for missing inputs.
- UXON starts brand/color/font/media import automatically from the website URL.
- DNS work pauses safely until records are updated.
- Tracking setup follows the GTM/direct-mode guardrails.
