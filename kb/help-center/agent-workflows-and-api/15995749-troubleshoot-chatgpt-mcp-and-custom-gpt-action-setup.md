# Troubleshoot ChatGPT MCP and Custom GPT Action setup

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary

- Fix common setup, authentication, schema, and permission issues when connecting UXON to ChatGPT.
- Use this guide when UXON does not connect to ChatGPT, a Custom GPT Action fails, or ChatGPT cannot return UXON data.
- Start with the fastest checks before changing settings.

## Source

- Help Center: [Troubleshoot ChatGPT MCP and Custom GPT Action setup](https://docs.uxon.ai/en/articles/15995749-troubleshoot-chatgpt-mcp-and-custom-gpt-action-setup)
- Source collection: Agent workflows and API

## Related UXON Guides

- [Agent command playbook](../../../SKILLS.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)
- [Knowledge base API](../../../skills/knowledge-base.md)

## Article

Use this guide when UXON does not connect to ChatGPT, a Custom GPT Action fails, or ChatGPT cannot return UXON data.

## Fast checks

1. Confirm you are using the correct UXON connection path: **ChatGPT MCP** uses OAuth, while **Custom GPT Actions** use an API key.
2. Confirm the UXON endpoint is typed exactly: **https://uxon.ai/api/mcp** for MCP, or **https://uxon.ai/api/external/commands** for Custom GPT Actions.
3. Confirm your UXON account or API key has access to the sub-account you are asking about.
4. Try the simplest read request first: **Show my UXON sub-accounts.**

## ChatGPT MCP issues

| Issue | What to check |
| --- | --- |
| Developer mode is missing | Ask your ChatGPT workspace admin to allow Developer mode or custom/developer-mode apps. |
| ChatGPT cannot create the app | Check that the MCP server URL is **https://uxon.ai/api/mcp** and that your workspace allows third-party apps. |
| OAuth sign-in does not open | Disconnect and reconnect the app. Make sure browser popups or redirects are not blocked. |
| Access denied after UXON sign-in | Your UXON team may not have connector access, or your UXON role/plan may not allow connector use. |
| Connected, but no tools appear | Open the app settings in ChatGPT and refresh the app/tool metadata. |
| A write action asks for confirmation | This is expected. ChatGPT and UXON can require confirmation before higher-impact actions. |

## Custom GPT Action issues

| Issue | What to check |
| --- | --- |
| Schema will not save | Paste the full schema from the article. Do not add comments inside the JSON. |
| Authentication fails with 401 | Use **API Key** authentication with auth type **Bearer**, and paste only the UXON API key value. |
| The GPT says it needs a siteId | Run **subaccounts.list** first, then use the returned sub-account ID as **siteId**. |
| The API returns invalid command input | Use the exact input fields for that command. For example, **landing_pages.list** only needs **siteId**. |
| The API returns 403 | External API access may not be enabled, or the key may not have access to that team or sub-account. |
| The API returns 429 | The API key hit its rate limit. Wait for the reset window and retry. |

## What to send support

If the issue continues, send UXON support:

- Which path you are using: ChatGPT MCP or Custom GPT Actions.
- The approximate time the issue happened.
- The UXON team or sub-account name.
- The exact error message from ChatGPT or the GPT Action test panel.
- Do not send your full API key. If support needs to identify a key, send only the key name or the last four visible characters.

## OpenAI references

- [Connect from ChatGPT](https://developers.openai.com/apps-sdk/deploy/connect-chatgpt)
- [Apps SDK authentication](https://developers.openai.com/apps-sdk/build/auth)
- [Configuring Actions in GPTs](https://help.openai.com/en/articles/9442513-configuring-actions-in-gpts)
