# Import Code Pages With A ZIP File

UXON can import a static landing page ZIP as a page variant. This is useful when a page was built outside UXON by Claude Code, Codex, Cursor, v0, Webflow, Lovable, or a custom build system. UXON hosts the imported variant and keeps publishing, global scripts, tracking, and A/B testing connected.

Source Help Center article: [Import code pages with a ZIP file](https://docs.uxon.ai/en/articles/13570175-import-code-pages-via-zip)

## When To Use Code Page Import

Use code page import when:

- You already have a complete landing page built elsewhere.
- You want UXON to handle hosting and publishing.
- You want the imported page to participate in UXON variants and experiments.
- You want global scripts and pixels applied automatically.

## ZIP Requirements

The ZIP must contain final built output:

```text
my-page.zip
+-- index.html
+-- assets/
|   +-- index.css
|   +-- index.js
|   +-- hero.webp
+-- favicon.ico
```

Rules:

- `index.html` must be at the root of the ZIP.
- Referenced assets must be included.
- Upload compiled output, not source project files.

## API Command

```json
{
  "command": "landing_pages.code_variant.upload",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantName": "Agent Built Variant",
    "zipUrl": "https://example.com/builds/landing-page.zip",
    "makeMain": false,
    "publish": false
  }
}
```

## Troubleshooting

Most import failures come from a missing root `index.html`, missing referenced assets, or uploading a framework source project instead of the built output.

## Related Files

- [Landing pages API](../../skills/landing-pages.md)
- [Create landing page example](../../examples/curl/create-landing-page.sh)
