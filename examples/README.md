# UXON Examples

These examples show how developers and AI agents can call UXON from shell scripts or MCP chat prompts.

## cURL Examples

- [Create a blank landing page](curl/create-landing-page.sh)
- [Generate an AI landing page from brief](curl/generate-ai-landing-page.sh)
- [Read and update branding](curl/branding-overview-and-update.sh)
- [Launch an experiment draft](curl/launch-experiment.sh)
- [Set up GTM tracking](curl/setup-tracking.sh)
- [Pull an experiment report](curl/pull-report.sh)

## MCP Prompt Examples

- [Claude first client setup prompt](mcp/claude-onboarding-prompt.md)
- [Claude weekly CRO check prompt](mcp/claude-weekly-check.md)

## Environment Variables

The shell examples expect environment variables such as:

```bash
export UXON_API_KEY='uxon_live_REPLACE_WITH_REAL_KEY'
export UXON_SITE_ID='site_uuid'
```

Do not commit real API keys to GitHub.
