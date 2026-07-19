# Connect UXON to ChatGPT with MCP

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary

- Set up UXON as a ChatGPT app using the UXON MCP endpoint and OAuth sign-in.
- Use this guide to connect UXON to ChatGPT through MCP.
- This is the closest OpenAI equivalent to the Claude custom connector.

## Source

- Help Center: [Connect UXON to ChatGPT with MCP](https://docs.uxon.ai/en/articles/15995745-connect-uxon-to-chatgpt-with-mcp)
- Source collection: Agent workflows and API

## Related UXON Guides

- [Agent command playbook](../../../SKILLS.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)
- [Knowledge base API](../../../skills/knowledge-base.md)

## Article

Use this guide to connect UXON to ChatGPT through MCP. This is the closest OpenAI equivalent to the Claude custom connector.

## Before you start

- You need an active UXON account.
- Your UXON team must have connector access enabled.
- Your ChatGPT workspace must allow Developer mode or custom/developer-mode apps.
- Use ChatGPT on the web for the first setup. After it is connected, the app may also be available in supported ChatGPT clients.

## Connection values

| Field | Value |
| --- | --- |
| MCP server URL | **https://uxon.ai/api/mcp** |
| Authentication | UXON OAuth sign-in |
| Protected resource metadata | **https://uxon.ai/.well-known/oauth-protected-resource** |
| OAuth authorization metadata | **https://uxon.ai/.well-known/oauth-authorization-server** |

## Connect in ChatGPT

1. Open ChatGPT.
2. Go to **Settings > Security and login** and turn on **Developer mode**. If you cannot see this option, ask your ChatGPT workspace admin to enable it.
3. Go to **Settings > Plugins**, or open **chatgpt.com/plugins**.
4. Select the plus button to create a developer-mode app.
5. Set the app name to **UXON**.
6. Use this description: **Use UXON to manage sub-accounts, landing pages, experiments, tracking, domains, goals, and reporting from chat.**
7. Set **MCP server URL** to **https://uxon.ai/api/mcp**.
8. Select **Create**. ChatGPT should discover the UXON tools from the MCP server.
9. Open a new ChatGPT conversation, select **+** near the message box, choose **More**, and select **UXON**.
10. When ChatGPT asks you to connect or sign in, complete the UXON OAuth sign-in flow.

## First success check

After connecting, ask ChatGPT:

- **Show my UXON sub-accounts.**
- **What UXON actions can you help me with?**

If ChatGPT returns your UXON data, the connection is working.

## What ChatGPT can do

- List and inspect sub-accounts.
- Read landing page, experiment, domain, goal, and reporting data.
- Guide setup workflows in chat.
- Ask for confirmation before higher-impact actions, depending on ChatGPT app permissions and UXON tool rules.

## Keep in mind

- Do not paste a UXON API key into the MCP app setup. This connection uses OAuth, so each user signs in as themselves.
- OpenAI may label this area as **Apps**, **Plugins**, or **developer-mode apps** in different ChatGPT screens.
- Business, Enterprise, and Education workspaces may have admin controls that limit app access or tool permissions.
- For public distribution outside developer mode, OpenAI requires an app/plugin submission and review process.

## OpenAI reference

OpenAI setup guide: [Connect from ChatGPT](https://developers.openai.com/apps-sdk/deploy/connect-chatgpt).
