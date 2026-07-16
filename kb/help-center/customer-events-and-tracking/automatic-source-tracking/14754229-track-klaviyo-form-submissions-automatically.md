# Track Klaviyo form submissions automatically

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Measure completed Klaviyo form submissions as conversion events for clearer funnel reporting.
- Use this setup to automatically track Klaviyo form completions as conversion events in UXON AI.
- Go to **Dashboard** -> **Event Tracking**.

## Source
- Help Center: [Track Klaviyo form submissions automatically](https://docs.uxon.ai/en/articles/14754229-track-klaviyo-form-submissions-automatically)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use this setup to automatically track Klaviyo form completions as conversion events in UXON AI.

## Set up Klaviyo form tracking

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, open **Klaviyo Forms** and select **Configure events**.
3. Set **Report captured action as** (usually **Lead** or **Subscribe**).
4. Select **Enable**.

## What gets tracked

- Klaviyo form submission completed
- Captured after successful form submit event

## Strategy tip

If Klaviyo opt-ins and lead forms serve different goals, map them to separate event names so lifecycle reporting stays clearer.

## Troubleshooting

**Submission is visible in Klaviyo but not in UXON.**

- Ensure the source is enabled in UXON and run a fresh form completion test.
- Verify the conversion domain is approved for tracking.

**Data is fragmented across many event names.**

- Consolidate naming in mapping so one business outcome uses one core event label.
