# Open CTA buttons in a new tab

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Use the Open in new tab option on button elements when you want visitors to keep your landing page open.
- If a CTA sends users to checkout, docs, or external pages, opening in a new tab can keep your landing page session intact.
- Enable new-tab behavior on a button 1.

## Source
- Help Center: [Open CTA buttons in a new tab](https://docs.uxon.ai/en/articles/14754559-open-cta-buttons-in-a-new-tab)
- Source collection: Builder overview / Buttons, links, and conversion actions

## Related UXON Guides
- [Landing pages API](../../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../../landing-pages/import-code-pages.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)

## Article
If a CTA sends users to checkout, docs, or external pages, opening in a new tab can keep your landing page session intact.

## Enable new-tab behavior on a button

1. Select the button in Builder.
2. Open **Element settings**.
3. Turn on **Open in new tab**.
4. Save and test in preview.

## When to use this setting

- External resources (case studies, docs, partner sites)
- Long checkout flows where you want users to return easily
- Outbound content that supports decision-making

## When to avoid it

- Core funnel steps where users should stay in one guided journey
- Simple in-page navigation (use anchors instead)

> Apply this intentionally. Too many new tabs can break focus and hurt conversions.

## Troubleshooting

**CTA still opens in the same tab.**

- Reopen button settings and confirm **Open in new tab** is enabled.

**Users feel lost after external click.**

- Improve CTA copy so visitors know they are leaving the landing page.
