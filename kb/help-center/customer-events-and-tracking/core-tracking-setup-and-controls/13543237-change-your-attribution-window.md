# Change your attribution window

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Change attribution window settings.
- You can change the attribution window to control how long conversions are attributed after a user interaction.
- This setting applies to the tracking pixel and affects experiments and variants.

## Source
- Help Center: [Change your attribution window](https://docs.uxon.ai/en/articles/13543237-change-your-attribution-window)
- Source collection: Customer events and tracking / Core tracking setup and controls

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
You can change the attribution window to control how long conversions are attributed after a user interaction.

This setting applies to the tracking pixel and affects experiments and variants.

### How to change the attribution window

1. Go to **Customer Events**.
2. In **Tracking Pixel**, select **Pixel settings**.
3. Under **Attribution Window**, choose one option:24 hours
4. 3 days (recommended)
5. 7 days
6. 14 days
7. Select **Save Settings**.

#### Notes

- You can only choose from the available options above, custom day values are not supported.
- This setting controls how long experiment and variant cookies persist for attribution.
