# Track revenue for lead events

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Track lead value as revenue.
- You can include revenue data for Lead events by sending a numeric value with the event payload, which UXON AI uses in revenue totals.
- UXON AI stores event properties in pixel_events.data and calculates revenue by summing data.value for events that include it.

## Source
- Help Center: [Track revenue for lead events](https://docs.uxon.ai/en/articles/13543230-track-revenue-for-lead-events)
- Source collection: Customer events and tracking / Revenue, ads, and troubleshooting

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
You can include revenue data for Lead events by sending a numeric value with the event payload, which UXON AI uses in revenue totals.

UXON AI stores event properties in `pixel_events.data` and calculates revenue by summing `data.value` for events that include it.

### How to track a lead value

1. Go to **Customer Events**.
2. In the events table, find **Lead**.
3. Open the menu and select **View Detail**.
4. Use the extended tracking syntax to pass a numeric value, and optionally a currency.

```text
uxon('track', 'Lead', { value: 99.00, currency: 'USD' });
```

#### Notes

- `value` must be a number, it is used to calculate revenue totals.
- `currency` is accepted as event data, but revenue totals are calculated from `value` only, no currency conversion is applied.
