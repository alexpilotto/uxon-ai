# Track phone call clicks automatically

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Capture phone-link clicks (tel:) as conversion events to measure call intent from your landing pages.
- Use this setup to track call-intent actions when visitors tap or click phone links on your UXON AI landing pages.
- Go to **Dashboard** -> **Event Tracking**.

## Source
- Help Center: [Track phone call clicks automatically](https://docs.uxon.ai/en/articles/14754230-track-phone-call-clicks-automatically)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use this setup to track call-intent actions when visitors tap or click phone links on your UXON AI landing pages.

## Set up phone click tracking

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, go to **Website Actions**.
3. Open **Phone Clicks** and select **Configure events**.
4. Map **Report captured action as** (for example **Phone Click** or **Lead**).
5. Select **Enable**.

## What gets tracked

- Any click on links using the **tel:** protocol
- Captured only when users intentionally tap or click the phone link

## Implementation note

This tracking only works for clickable phone links (for example ``). Plain text phone numbers are not counted as click events.

## Troubleshooting

**No phone click events appear.**

- Check that your CTA uses a **tel:** link, not plain text.
- Confirm Phone Clicks source is enabled and correctly mapped.

**Events appear under an unexpected label.**

- Update mapping in **Edit configuration** and save changes.
