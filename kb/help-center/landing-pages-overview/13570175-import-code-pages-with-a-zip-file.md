# Import code pages with a ZIP file

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Import external landing pages by ZIP from the dashboard, API, MCP, or Claude connector.
- Use **code pages** to publish a landing page variant that was built outside UXON, for example Claude Code, Cursor, Codex, Webflow, Lovable and other tools, as long as the final upload is a static ZIP with index.html at the root.
- UXON hosts the page, publishes it to your connected domain, and keeps Global Scripts and A/B testing working automatically.

## Source
- Help Center: [Import code pages with a ZIP file](https://docs.uxon.ai/en/articles/13570175-import-code-pages-with-a-zip-file)
- Source collection: Landing pages overview

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Agent command playbook](../../../SKILLS.md)
- [Claude onboarding prompt](../../../examples/mcp/claude-onboarding-prompt.md)

## Article
Use **code pages** to publish a landing page variant that was built outside UXON, for example Claude Code, Cursor, Codex, Webflow, Lovable and other tools, as long as the final upload is a static ZIP with `index.html` at the root.

UXON hosts the page, publishes it to your connected domain, and keeps Global Scripts and A/B testing working automatically.

## When to use this

Use code page import when you already have a complete landing page generated elsewhere and you do not want to rebuild it in the UXON editor. This approach lets you continue managing publishing, variants, and experiments inside UXON without changing your existing code.

## What's supported

UXON accepts a ZIP file containing a static, built web page. The ZIP must include an `index.html` file at its root and all assets referenced by the page, such as CSS, JavaScript, images, and fonts.

So the practical format is:

```text
my-page.zip
 index.html
 assets/
 index-abc123.css
 index-def456.js
 hero-xyz789.webp
 favicon.ico
```

> The ZIP must be a final build output, for example a `dist` or `build` folder, not a source project.

## ZIP requirements

Your ZIP file must meet all of the following requirements:

- `index.html` must be at the root of the ZIP, not inside a nested folder.
- All referenced assets must be included in the ZIP.
- The ZIP must contain compiled output, not framework source files.

> Common issues occur when `index.html` is nested inside a folder, assets are missing, or a framework project is uploaded without being built first.

## How to import a code page

1. Go to **Landing Pages** and open the landing page you want to edit.
2. Select **Create variant**.
3. Choose **Import code page (ZIP)**.
4. Upload your ZIP file.

UXON creates a new variant and prepares it for preview and publishing.

## For AI agents, API keys, and Claude connector

External AI agents can upload or replace a code-page ZIP without using the dashboard, as long as they have an authorized UXON API key or Claude connector session.

- Use the command `landing_pages.code_variant.upload`.
- Provide `siteId` and `landingPageId`.
- Provide exactly one ZIP source: `zipUrl` for an HTTPS download URL, or `zipBase64` for inline ZIP content.
- Omit `variantId` to create a new code variant, or include `variantId` to replace an existing code variant.
- Optionally set `makeMain` to make the uploaded variant the main variant, and `publish` to publish after upload.

> For larger ZIPs, use `zipUrl`. The URL must be HTTPS and directly downloadable by UXON.

```text
{
 "command": "landing_pages.code_variant.upload",
 "input": {
 "siteId": "site_123",
 "landingPageId": "lp_123",
 "variantName": "Claude Code Variant",
 "zipUrl": "https://example.com/my-page.zip",
 "makeMain": true,
 "publish": true
 }
}
```

## Replacing an imported ZIP

If you need to update your code, regenerate your page bundle and create a new ZIP. From the variant's 3-dot menu, select **Replace ZIP** and upload the updated file.

If you want to start over completely, you can delete the variant and import a new ZIP instead.

## Previewing a code variant

You can preview the imported variant using **Preview** or the eye icon. The variant opens in a new tab and behaves like any other variant, including automatic variant key handling.

## Downloading the ZIP

If enabled, you can download the ZIP for a code variant from the 3-dot menu using **Download ZIP**.

## Troubleshooting

If the import fails, the variant may show an **Error** badge. Hover over the badge to see the reason. Most errors are caused by a missing `index.html` at the ZIP root or missing referenced assets.

After fixing the ZIP, use **Replace ZIP** to upload again.

### Notes

UXON continues to handle publishing to your connected domain and powering A/B testing.

> Any **Global Scripts** configured in UXON are applied automatically, so you do not need to manually add pixels or scripts to imported pages.

### Example

You can download an example code page here:
