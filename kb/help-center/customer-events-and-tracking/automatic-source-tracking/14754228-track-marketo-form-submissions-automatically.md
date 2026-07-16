# Track Marketo form submissions automatically

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Capture Marketo form submit events automatically and map them to your UXON conversion goals.
- Use this setup when your lead generation relies on Marketo forms and you want reliable conversion tracking inside UXON AI.
- Go to **Dashboard** -> **Event Tracking**.

## Source
- Help Center: [Track Marketo form submissions automatically](https://docs.uxon.ai/en/articles/14754228-track-marketo-form-submissions-automatically)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use this setup when your lead generation relies on Marketo forms and you want reliable conversion tracking inside UXON AI.

## Set up Marketo form tracking

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, select **Marketo Forms** -> **Configure events**.
3. Choose the event mapping in **Report captured action as** (typically **Lead**).
4. Select **Enable**.

## What gets tracked

- Marketo form submitted successfully
- Captured only after successful submit callback

## Measurement tip

If Marketo form submits are your main paid-traffic goal, keep naming consistent across channels so weekly reporting stays comparable.

## Troubleshooting

**Submissions happen but no conversion appears.**

- Check that the mapped event name is included in your reporting filters.
- Confirm the submit flow completes on an approved domain.

**Tracking status doesn't move to Connected.**

- Re-run a real form submission after enabling and wait for status update.
