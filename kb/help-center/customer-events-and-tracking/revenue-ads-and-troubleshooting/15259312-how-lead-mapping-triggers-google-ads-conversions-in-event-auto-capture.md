# How Lead mapping triggers Google Ads conversions in Event Auto-Capture

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Understand when UXON fires Google Ads conversions from Lead-mapped auto-capture sources.
- When Event Auto-Capture is mapped to **Lead**, UXON can also fire your configured Google Ads conversion event.
- Before you start Open **Dashboard** -> **Event Tracking**.

## Source
- Help Center: [How Lead mapping triggers Google Ads conversions in Event Auto-Capture](https://docs.uxon.ai/en/articles/15259312-how-lead-mapping-triggers-google-ads-conversions-in-event-auto-capture)
- Source collection: Customer events and tracking / Revenue, ads, and troubleshooting

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
When Event Auto-Capture is mapped to **Lead**, UXON can also fire your configured Google Ads conversion event.

## Before you start

- Open **Dashboard** -> **Event Tracking**.
- In Lead event settings, add your Google Ads **Conversion ID** and **Conversion Label**, and enable tracking.
- Ensure Google tag (gtag) is loaded in Global Scripts (``).

## Enable optional Google Ads firing per source

1. Open the source in **Event Auto-Capture**.
2. Set **Report captured action as** to **Lead**.
3. Turn on **Also fire Google Ads conversion for Lead** (default is OFF).
4. Save changes.

## When conversion fires

- A source in Event Auto-Capture is enabled.
- That source is mapped to **Lead**.
- The source checkbox **Also fire Google Ads conversion for Lead** is enabled.
- Lead Google Ads settings are enabled and valid.
- The action happens on a UXON landing page context.

## Supported sources

This applies to client-side auto-capture sources, such as HubSpot, Calendly, Typeform, Marketo Forms, Klaviyo Forms, and Phone Clicks, when mapped to **Lead**.

## When it does not fire

- The source is mapped to an event other than **Lead**.
- The source checkbox is OFF.
- Lead Google Ads tracking is disabled or missing ID/Label.
- Google tag is not available on the page.
- Event happens outside UXON landing page context.

> If you already fire the same Google Ads conversion from another tag flow, you may double-count conversions. Keep one primary tracking path per conversion action.

## Verify setup

1. Map a source to **Lead** and enable it.
2. Turn on the source checkbox for Google Ads firing.
3. Complete a real test action (form submit, booking, or phone click).
4. Use Tag Assistant to confirm a `conversion` event with your `send_to` value.
