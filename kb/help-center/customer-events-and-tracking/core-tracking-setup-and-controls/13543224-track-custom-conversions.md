# Track custom conversions

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Track custom conversion events.
- You can track custom conversions by creating a custom event and firing it at the exact moment the conversion happens using the UXON tracking API.
- Complete the setup until you reach the installation step.

## Source
- Help Center: [Track custom conversions](https://docs.uxon.ai/en/articles/13543224-track-custom-conversions)
- Source collection: Customer events and tracking / Core tracking setup and controls

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
You can track custom conversions by creating a custom event and firing it at the exact moment the conversion happens using the UXON tracking API.

### Create a custom event

1. Go to **Customer Events**.
2. Select **Add Event**.
3. Enter an **Event Name**.
4. Complete the setup until you reach the installation step.
5. Copy the tracking snippet.

The event name you define here is the same name you will use when tracking the conversion.

### Fire the conversion event

Trigger the event at the moment the conversion happens, for example after a form submission, button click, or purchase completion.

To track a basic conversion:

```text
uxon('track', '');
```

To include a value for revenue-style reporting, pass a value and optional currency:

```text
uxon('track', '', { value: 99.00, currency: 'USD' });
```

#### Notes

- The conversion is only recorded if the UXON pixel is running on the page where the event fires.
- UXON AI landing pages include the pixel automatically.
- For external pages, the pixel must be installed and the domain must be added to **Domain Whitelisting**.
