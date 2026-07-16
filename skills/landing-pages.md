# Landing Pages API

Create and manage landing pages programmatically with UXON. Use these commands to build pages from briefs, publish variants for A/B testing, upload externally coded pages, and pull landing page performance data.

## Core Commands

- `landing_pages.list`: list landing pages for one sub-account.
- `landing_pages.create`: create a landing page and optional initial variants.
- `landing_pages.update`: update page metadata, settings, knowledge base content, or variants.
- `landing_pages.code_variant.upload`: upload or replace an externally coded static page ZIP as a UXON variant.
- `landing_pages.set_status`: set a page to `draft` or `live`.

## Create A Landing Page

```json
{
  "command": "landing_pages.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer"
  }
}
```

If variants are omitted, UXON creates a default control variant.

## Upload A Custom Code Variant

Use `landing_pages.code_variant.upload` when an agent or build system produces a static page bundle outside the UXON visual builder.

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

ZIP requirements:

- Upload the final built static output, not source project files.
- Include `index.html` and all referenced assets.
- Supported assets include CSS, JavaScript, JSON, SVG, images, fonts, audio, video, manifest, XML, source maps, and WASM.
- UXON injects pixels, global scripts, and page metadata automatically.

## Publish A Page

```json
{
  "command": "landing_pages.set_status",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "status": "live"
  }
}
```

Publishing is a high-impact action. Agents should confirm with the operator before calling `landing_pages.set_status` with `live`.

## Related Reports

- `reports.landing_pages.summary`
- `reports.landing_page.details`
- `reports.landing_page.variant_metrics`
- `reports.landing_page.trends`
- `reports.landing_page.channels`

## Related Files

- [Experiments](experiments.md)
- [Reports](reports.md)
- [Create landing page example](../examples/curl/create-landing-page.sh)
