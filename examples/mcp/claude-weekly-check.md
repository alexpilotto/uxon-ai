# Claude Prompt: Weekly CRO Check

Use this prompt after connecting Claude to UXON through the MCP connector.

```text
Run a weekly CRO check for my UXON accounts.

List active landing pages and running experiments.
Pull landing page summaries and experiment summaries for the last 30 days.
Flag the pages, experiments, or channels that most need review.
Do not publish, pause, start, or edit anything without asking me first.
```

Expected behavior:

- Claude uses read-only report tools first.
- Claude summarizes account state before recommending changes.
- High-impact changes remain approval-gated.
