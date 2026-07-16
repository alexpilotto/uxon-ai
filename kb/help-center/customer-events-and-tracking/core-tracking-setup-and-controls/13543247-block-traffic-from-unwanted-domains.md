# Block traffic from unwanted domains

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Block traffic with domain whitelisting.
- Domain whitelisting controls which domains are allowed to send analytics data to your pixel.
- This helps prevent unwanted traffic and avoids unnecessary traffic balance consumption.

## Source
- Help Center: [Block traffic from unwanted domains](https://docs.uxon.ai/en/articles/13543247-block-traffic-from-unwanted-domains)
- Source collection: Customer events and tracking / Core tracking setup and controls

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)
- [Domains API](../../../../skills/domains.md)
- [Connect a custom domain](../../../domains/connect-custom-domain.md)

## Article
Domain whitelisting controls which domains are allowed to send analytics data to your pixel. This helps prevent unwanted traffic and avoids unnecessary traffic balance consumption.

Domains connected to UXON AI landing pages are whitelisted automatically, you do not need to add them again.

### When to use domain whitelisting

A common use case is A/B testing with external pages that are not created in UXON AI. By whitelisting an external domain, you explicitly allow the UXON pixel to collect data from that site, while blocking data from all other unapproved domains.

### How to whitelist a domain

1. Go to **Customer Events**.
2. Scroll to **Domain Whitelisting**.
3. Select **Whitelist Domain**.
4. Enter the **root domain** only, not a single page URL.
5. Select **Whitelist**.

#### Notes

- Only root domains are supported, subpages and full URLs are not allowed.
- Events from domains that are not whitelisted are ignored.
- Whitelisting helps protect your data quality and reduces unnecessary traffic usage.
