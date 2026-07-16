# Track conversions from Shopify, forms, bookings, and calls

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Understand what Event Auto-Capture tracks and what you need in place before enabling it.
- Event Auto-Capture helps marketers capture key conversion actions from connected tools without writing manual tracking rules for each one.
- Requirements before you enable auto-capture Open the correct workspace and client account where your landing pages are managed.

## Source
- Help Center: [Track conversions from Shopify, forms, bookings, and calls](https://docs.uxon.ai/en/articles/14754180-track-conversions-from-shopify-forms-bookings-and-calls)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Event Auto-Capture helps marketers capture key conversion actions from connected tools without writing manual tracking rules for each one.

## Supported auto-capture sources

In **Event Tracking**, UXON supports both platform integrations and website actions:

- **Platforms**: HubSpot, Calendly, Shopify, Typeform, Marketo Forms, and Klaviyo Forms
- **Website Actions**: Phone link clicks

Each source can be turned on separately, so you only track what is active in your funnel.

## Requirements before you enable auto-capture

- Open the correct workspace and client account where your landing pages are managed.
- Confirm your conversion page includes the UXON tracking pixel. UXON landing pages include this by default.
- If conversion happens on an external domain, add that domain in **Domain Whitelisting**.
- Enable only the platforms you actually use to keep reporting clean.

> For accurate cross-domain attribution, the UXON pixel must run on the page where the form submission or checkout completion happens.

## How Event Auto-Capture works in UXON

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, select **Configure events** for a source.
3. Choose how the captured action should be reported (for example Lead or Purchase).
4. Select **Enable**.

After enabling, you can return anytime to edit configuration or disable tracking for that source.

## Connection status labels

- **Connected**: UXON is receiving events from that source.
- **Not connected**: no confirmed event receipt yet.
- **Connection issue**: integration needs attention before reliable tracking resumes.

## Troubleshooting

**Auto-capture is visible but locked.**

- Your current plan may not include Event Auto-Capture. Ask your admin to update access.

**I enabled a source but still see Not connected.**

- Run one real conversion action first, then check status again.
