# Landing Pages API

Create and manage landing pages programmatically with UXON. Use these commands to create blank pages, submit AI landing page briefs, poll generation jobs, manage variants, publish changes, create review links, upload externally coded pages, and pull landing page performance data.

## Core Commands

- `landing_pages.list`: list landing pages for one sub-account.
- `landing_pages.get`: get landing page metadata, variants, preview URLs, and live URLs.
- `landing_pages.create`: create a draft landing page with one blank builder `Control` variant.
- `landing_pages.generate_from_brief`: submit the real UXON AI landing page generation pipeline.
- `landing_pages.generation_status`: poll a UXON AI landing page generation job.
- `landing_pages.update`: update page metadata, `settings.publish`, or `knowledgeBase`.
- `landing_pages.duplicate`: duplicate a landing page and its builder variants.
- `landing_pages.delete`: delete a landing page after explicit confirmation.
- `landing_pages.publish_changes`: publish current draft variant changes to the live page.
- `landing_pages.review_link`: create a review link for preview comments or approvals.
- `landing_pages.variants.create`: create a blank builder/code variant or duplicate from an existing variant.
- `landing_pages.variants.get`: get one variant.
- `landing_pages.variants.update`: update one variant's name, settings, or builder state.
- `landing_pages.variants.set_main`: set the main variant.
- `landing_pages.variants.duplicate`: duplicate one builder variant.
- `landing_pages.variants.delete`: delete one variant after explicit confirmation.
- `landing_pages.code_variant.upload_init`: create a signed upload URL for a custom code ZIP.
- `landing_pages.code_variant.upload_complete`: import a custom code ZIP after signed upload completes.
- `landing_pages.code_variant.upload`: upload or replace an externally coded static page ZIP as a UXON variant.
- `landing_pages.set_status`: set a page to `draft` or `live`.

## Create A Blank Landing Page

```json
{
  "command": "landing_pages.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer"
  }
}
```

This creates one blank builder `Control` variant. It does not run AI generation.

## Submit An AI Landing Page Brief

```json
{
  "command": "landing_pages.generate_from_brief",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer",
    "brief": {
      "brandName": "Acme Dental",
      "websiteUrl": "https://acmedental.com",
      "language": "English (US)",
      "funnelStrategy": "Service",
      "buyerGroup": "Consumers (B2C)",
      "desiredAction": "Submit a form",
      "market": "Brisbane, Queensland",
      "serviceOrProduct": "Emergency dental appointments",
      "idealClient": "Adults with urgent dental pain"
    }
  }
}
```

Poll the returned job with `landing_pages.generation_status`.

## Agent-Writable Page Objects

For `landing_pages.create` and `landing_pages.update`, agents should only write the publish settings object:

```json
{
  "publish": {
    "domain": "www.example.com",
    "path": "/offer",
    "hideFromSearch": true
  }
}
```

Do not send `settings.published`. That is UXON's internal full page-builder/published snapshot. Do not construct page-builder state inside `settings`.

`knowledgeBase` stores page notes/brief context only. It does not run AI generation. Recommended shape:

```json
{
  "summary": "Short context for the page",
  "notes": ["Important note"],
  "links": [{ "label": "Brief", "url": "https://example.com" }],
  "raw": {}
}
```

## Manage Variants

```json
{
  "command": "landing_pages.variants.create",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "name": "Variant B",
    "sourceVariantId": "lpv_control_uuid",
    "variantType": "builder"
  }
}
```

Use `landing_pages.variants.get`, `landing_pages.variants.update`, `landing_pages.variants.set_main`, `landing_pages.variants.duplicate`, and `landing_pages.variants.delete` for variant operations.

## Upload A Custom Code Variant

Use `landing_pages.code_variant.upload` for simple URL/base64 uploads. Use the two-step upload flow for larger files. The two-step flow needs an existing code variant ID, usually created with `landing_pages.variants.create` and `variantType: "code"`.

```json
{
  "command": "landing_pages.code_variant.upload_init",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_code_uuid",
    "fileName": "landing-page.zip",
    "size": 248000
  }
}
```

Upload the ZIP to the returned `uploadUrl`, then call:

```json
{
  "command": "landing_pages.code_variant.upload_complete",
  "input": {
    "siteId": "site_uuid",
    "landingPageId": "lp_uuid",
    "variantId": "lpv_code_uuid",
    "uploadToken": "returned_upload_token"
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

Publishing and deleting are high-impact actions. Agents should confirm with the operator first.

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
