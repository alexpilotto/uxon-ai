# Refresh a live landing page in UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Use Force content refresh when a published landing page is showing an older version than Builder.
- Use **Force content refresh** when a published landing page is not showing the latest live version you expect.
- This can help when the page you see in Builder and the public page on your domain do not match after publishing.

## Source
- Help Center: [Refresh a live landing page in UXON AI](https://docs.uxon.ai/en/articles/15793923-refresh-a-live-landing-page-in-uxon-ai)
- Source collection: Publishing and domains

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Domains API](../../../skills/domains.md)
- [Connect a custom domain](../../domains/connect-custom-domain.md)

## Article
Use **Force content refresh** when a published landing page is not showing the latest live version you expect.

This can help when the page you see in Builder and the public page on your domain do not match after publishing.

## When to use this

Use this action when:

- You have already published the landing page or published changes.
- The public page still appears to show an older version.
- You want UXON AI to refresh the live page cache for one landing page.

> **Important:** Force content refresh does not publish draft edits. If you have unpublished changes, select **Publish changes** first.

## How to refresh a live page

1. Go to **Dashboard** -> **Landing Pages**.
2. Open the published landing page.
3. Select the three-dot menu in the page header.
4. Select **Force content refresh**.
5. Wait for the confirmation message: **Live page refreshed.**
6. Select **Open published page** to check the live page.

## When the option is disabled

**Force content refresh** is only available when UXON AI can refresh a real published page.

The option may be disabled when:

- The landing page is still a draft.
- The page does not have a published domain and path.
- The page is currently publishing, unpublishing, or refreshing.
- Your role or plan cannot manage landing pages.

## What this refreshes

For that one landing page, UXON AI refreshes the saved live page output and asks the hosting cache to serve a fresh version. UXON AI also warms the public URL so the next visitor should receive the refreshed page quickly.

This action does not change your page design, tracking settings, domain records, or experiment setup.

## Troubleshooting

**The public page still looks old.**

- Open the page from the **Open published page** button after the refresh finishes.
- Try a hard refresh or open the page in a private browser window.
- Check whether the page still has **Unpublished changes**. If it does, select **Publish changes** first.

**The refresh failed.**

- Wait a moment and try **Force content refresh** again.
- Confirm the page is still published and the published URL is configured.
- If it keeps failing, contact support and include the landing page name and published URL.
