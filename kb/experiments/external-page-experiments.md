# Set Up External-Page Experiments

UXON can run experiments where one or both sides are external pages. External-page experiments require the UXON pixel on every external page that participates in assignment or conversion tracking. The earlier the pixel loads, the cleaner the assignment and attribution behavior.

Source Help Center article: [Set up external-page experiments in UXON AI](https://docs.uxon.ai/en/articles/15440025-set-up-external-page-experiments-in-uxon-ai)

## When You Need This

Use this setup when the experiment includes:

- UXON page vs external page.
- External page vs external page.
- URL-pattern target vs external page.

## External Page Requirements

Install the UXON pixel on:

- The external control URL.
- The external variant URL.
- External conversion pages, such as thank-you pages, checkout pages, booking confirmation pages, or custom conversion pages.

If the pixel is missing from one of those pages, UXON may not be able to assign the visitor, persist the correct variant, record exposure, or attribute conversion correctly.

## API Command

```json
{
  "command": "experiments.create",
  "input": {
    "siteId": "site_uuid",
    "nickname": "External Page Test",
    "selectedGoals": [
      { "id": "lead_goal_uuid", "name": "Lead" }
    ],
    "controlSource": "external",
    "controlPageUrl": "https://www.example.com/control",
    "variantSource": "external",
    "variantPageUrl": "https://www.example.com/variant",
    "preserveRedirectParams": true
  }
}
```

## Before Launch Checklist

- Control and variant URLs match the live URLs visitors will see.
- UXON pixel is installed on every external experiment page.
- UXON pixel is installed where conversion happens.
- External domains are approved for tracking.
- Conversion event is configured and can be tested.
- Traffic filters match the campaign audience.

## Related Files

- [Experiments API](../../skills/experiments.md)
- [Cross-domain experiment runbook](../../runbooks/cross-domain-experiment.md)
