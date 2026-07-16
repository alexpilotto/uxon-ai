# Do I need the UXON pixel to track conversions?

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- When the UXON pixel is required for conversions, experiments, external pages, and URL Pattern targets.
- UXON AI tracks conversions and experiment activity using the UXON pixel.
- Whether you need to install it manually depends on where the page is hosted and where the conversion happens.

## Source
- Help Center: [Do I need the UXON pixel to track conversions?](https://docs.uxon.ai/en/articles/13543223-do-i-need-the-uxon-pixel-to-track-conversions)
- Source collection: Customer events and tracking

## Related UXON Guides
- [Conversion tracking API](../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../tracking/enhanced-conversions-gtm.md)
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)

## Article
UXON AI tracks conversions and experiment activity using the UXON pixel. Whether you need to install it manually depends on where the page is hosted and where the conversion happens.

## How conversion tracking works

UXON AI records conversions when the UXON pixel is present on the page where the conversion event occurs. The pixel is responsible for:

- sending conversion events, like leads, calls, bookings, purchases, or custom events
- supporting experiments, including assignment, redirects, exposure tracking, and attribution
- preserving visitor and campaign context for reporting

## When you do not need to install the pixel manually

You do not need to install anything manually if the page is hosted by UXON AI. UXON AI landing pages include the pixel automatically, so conversions and experiments are tracked without manual setup.

## When you do need to install the pixel

Install the UXON pixel anywhere conversion or experiment activity happens outside UXON AI landing pages. Common examples:

- external landing pages used in an experiment
- external pages matched by URL Patterns
- external thank-you pages or confirmation pages
- Shopify checkout or post-purchase pages
- booking, form, or checkout pages hosted outside UXON AI
- any non-UXON AI page where conversions should be tracked

## Experiments and the pixel

Experiments rely on the UXON pixel to work.

- If an experiment runs only on UXON AI landing pages, the pixel is already present.
- If an experiment includes External targets, install the pixel on those external pages.
- If an experiment uses URL Patterns, install the pixel on every page that should match the pattern.
- If conversions happen on an external domain, install the pixel where the conversion event fires.

> For the fastest external-page experiment delivery, install the pixel high in the page ``, before heavy third-party scripts.

## Setup steps

1. Go to **Pixel & Events**.
2. Open **Tracking Pixel**.
3. Select **Copy Code**.
4. Install the snippet on the external site or page.
5. In **Domain Whitelisting**, add the external domain so events are accepted.
6. Use **Verify Installation** to confirm the pixel is detected.

## Troubleshooting

**Pixel installed but no data appears.**

- Check that the domain is added in **Domain Whitelisting**.
- Confirm the pixel is installed on the page where the conversion or experiment entry happens.
- Run one real test event after installing the pixel.

**Not sure if the pixel is installed.**

- In **Tracking Pixel**, select **Verify Installation**.
