# Track Typeform submissions automatically

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Automatically turn completed Typeform submissions into conversion events in UXON AI.
- Use this setup to track completed Typeform submissions as conversions in UXON AI without adding manual event code for each form.
- Set up Typeform submission tracking 1.

## Source
- Help Center: [Track Typeform submissions automatically](https://docs.uxon.ai/en/articles/14754227-track-typeform-submissions-automatically)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use this setup to track completed Typeform submissions as conversions in UXON AI without adding manual event code for each form.

## Set up Typeform submission tracking

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, choose **Typeform** and select **Configure events**.
3. Set **Report captured action as** (usually **Lead**).
4. Select **Enable**.

## What gets tracked

- Typeform submission completed
- Captured after successful completion confirmation

## Requirements

- UXON pixel must be active where the conversion completes.
- External conversion domains must be allowed in **Domain Whitelisting**.

## Troubleshooting

**No events after Typeform completion.**

- Confirm Typeform source is enabled and mapped to the expected event name.
- Re-test completion and check Event Tracking table updates.

**Status shows Connection issue.**

- Reopen configuration, save again, then run one fresh test submission.
