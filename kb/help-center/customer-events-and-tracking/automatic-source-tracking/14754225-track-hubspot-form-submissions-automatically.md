# Track HubSpot form submissions automatically

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Capture HubSpot form conversions automatically and map them to your main UXON event.
- Use this setup to track HubSpot form submissions automatically in UXON AI so your landing page reporting stays clean and comparable.
- When to use this Use this if your lead forms are powered by HubSpot and you want each successful submit recorded as a conversion event in UXON AI.

## Source
- Help Center: [Track HubSpot form submissions automatically](https://docs.uxon.ai/en/articles/14754225-track-hubspot-form-submissions-automatically)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use this setup to track HubSpot form submissions automatically in UXON AI so your landing page reporting stays clean and comparable.

## When to use this

Use this if your lead forms are powered by HubSpot and you want each successful submit recorded as a conversion event in UXON AI.

## Set up HubSpot form tracking

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, find **HubSpot** and select **Configure events**.
3. In **Report captured action as**, choose an existing event (usually **Lead**) or create a new one.
4. Select **Enable**.

## What gets tracked

- HubSpot form submission completed
- Captured only after a successful submit event

## Requirements

- The UXON pixel must be present where conversion happens.
- UXON landing pages include the pixel by default.
- If conversion happens on an external domain, allow it in **Domain Whitelisting**.

## Troubleshooting

**Status stays Not connected.**

- Submit a real HubSpot form once after enabling.
- Confirm you enabled the correct source and event mapping.

**Leads are missing in reports.**

- Check that your report filters include the mapped event name.
