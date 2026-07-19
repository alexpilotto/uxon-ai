# ChatGPT, Custom GPTs, Claude, and API keys: which UXON connection should I use?

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary

- Choose the right UXON connection path for ChatGPT, Custom GPTs, Claude, and external agents.
- UXON can connect to AI tools in a few different ways.
- Use this guide to choose the right setup for your team.

## Source

- Help Center: [ChatGPT, Custom GPTs, Claude, and API keys: which UXON connection should I use?](https://docs.uxon.ai/en/articles/15995748-chatgpt-custom-gpts-claude-and-api-keys-which-uxon-connection-should-i-use)
- Source collection: Agent workflows and API

## Related UXON Guides

- [Agent command playbook](../../../SKILLS.md)
- [Agent workflows knowledge base](../../agent-workflows/connect-external-ai-agent.md)
- [Knowledge base API](../../../skills/knowledge-base.md)

## Article

UXON can connect to AI tools in a few different ways. Use this guide to choose the right setup for your team.

## Quick recommendation

- Use **Claude custom connector** or **ChatGPT MCP** for normal team chat workflows.
- Use **Custom GPT Actions** when you are building a private GPT and only need a controlled API-key setup.
- Use **API key + live SKILLS page** for advanced agent platforms, scripts, or custom automation outside Claude or ChatGPT.

## Compare options

| Connection path | Best for | Authentication | Notes |
| --- | --- | --- | --- |
| **Claude custom connector** | Day-to-day team use in Claude | UXON OAuth | Recommended for Claude users. Each teammate signs in as themselves. |
| **ChatGPT MCP app** | Day-to-day team use in ChatGPT | UXON OAuth | Closest OpenAI equivalent to the Claude connector. Requires ChatGPT app/developer-mode access. |
| **Custom GPT Actions** | Private GPTs and read/reporting workflows | UXON API key | Requires an OpenAPI schema. Best kept to read/reporting commands unless your team explicitly accepts write-action risk. |
| **API key + live SKILLS page** | Advanced agents, scripts, and automation | UXON API key | Most flexible. Your team is responsible for storing the API key securely and following the live command guide at `https://uxon.ai/api/skills`. |

## Choose ChatGPT MCP when

- You want ChatGPT users to connect with their own UXON login.
- You want ChatGPT to discover UXON tools from the MCP server.
- You want a setup similar to the Claude connector.
- Your ChatGPT workspace allows apps, plugins, or developer-mode apps.

## Choose Custom GPT Actions when

- You are creating one private GPT with a known purpose.
- Your workflow can use a dedicated UXON API key.
- You only need read/reporting commands or a tightly controlled command set.
- Your ChatGPT workspace allows custom actions for GPTs.

## Security defaults

- Prefer OAuth connections when a person will use the tool regularly in chat.
- Use dedicated API keys for Custom GPTs and automations.
- Restrict API keys to a single sub-account when possible.
- Rotate the key if it is pasted into the wrong place or shared with the wrong audience.
- Do not place API keys in prompts, uploaded files, or public GPT instructions.

## Next step

If your team uses ChatGPT, start with **Connect UXON to ChatGPT with MCP**. If your ChatGPT workspace cannot add apps, use **Connect a Custom GPT to UXON with Actions** as the fallback.
