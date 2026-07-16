# Track Shopify purchases and revenue automatically

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Track completed Shopify checkouts in UXON and optionally include revenue value.
- Use Shopify auto-capture to record checkout completions as conversion events in UXON, with optional revenue tracking for performance analysis.
- Before you start You need access to Shopify admin and UXON Event Tracking settings.

## Source
- Help Center: [Track Shopify purchases and revenue automatically](https://docs.uxon.ai/en/articles/14754182-track-shopify-purchases-and-revenue-automatically)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use Shopify auto-capture to record checkout completions as conversion events in UXON, with optional revenue tracking for performance analysis.

## Before you start

- You need access to Shopify admin and UXON Event Tracking settings.
- Make sure the UXON pixel is active on your landing pages and external conversion flow where required.
- If checkout happens on an external domain, confirm it is allowed in **Domain Whitelisting**.

## Enable Shopify auto-capture

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, find **Shopify** and select **Configure events**.
3. Set **Report captured action as** to your preferred outcome event (usually **Purchase**).
4. If you want order value in reporting, enable **Capture revenue data**.
5. Select **Enable**.

## Add the Shopify customer events code

1. Inside Shopify setup, select **Copy Code**.
2. Select **Open Customer Events** to open Shopify settings.
3. Create or update your Shopify customer event script and paste the copied code.
4. Save in Shopify, then run a test checkout.

## Validate setup

- After a successful checkout event, Shopify connection status should move to **Connected**.
- The mapped event name should appear in your Event Tracking data.

## Revenue and currency behavior

When revenue capture is enabled, UXON stores purchase value with each captured event. Reporting uses the currency selected in **Tracking Pixel** -> **Pixel settings**.

## Troubleshooting

**Shopify shows Not connected.**

- Confirm the latest copied code is saved in Shopify Customer Events.
- Run a real or test checkout completion after saving.

**Revenue is missing from events.**

- Turn on **Capture revenue data** in Shopify configuration.
- Confirm your checkout includes order value data.
