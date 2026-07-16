# Track Calendly bookings automatically

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Capture completed Calendly bookings as conversion events without manual tagging.
- Use this setup to automatically record successful Calendly bookings as conversion events in UXON AI.
- When to use this Use this if your funnel includes Calendly booking flows and you want them measured as lead outcomes in your landing page reporting.

## Source
- Help Center: [Track Calendly bookings automatically](https://docs.uxon.ai/en/articles/14754226-track-calendly-bookings-automatically)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use this setup to automatically record successful Calendly bookings as conversion events in UXON AI.

## When to use this

Use this if your funnel includes Calendly booking flows and you want them measured as lead outcomes in your landing page reporting.

## Set up Calendly booking tracking

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, find **Calendly** and select **Configure events**.
3. Set **Report captured action as** (typically **Lead** or **Book Demo**).
4. Select **Enable**.

## What gets tracked

- Calendly meeting successfully scheduled
- Captured when a booking confirmation is completed

## Best practice

If your team treats booked calls as a core KPI, map this source to a dedicated event name (for example **Book Demo**) to separate it from general lead form submissions.

## Troubleshooting

**Bookings happen but nothing appears.**

- Run a fresh booking test after enabling and wait for status refresh.
- Verify the conversion page is covered by UXON pixel + domain settings.

**Wrong event label appears.**

- Open **Edit configuration**, change mapping, and save.
