# Track ecommerce revenue

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Track eCommerce purchase revenue.
- You can track eCommerce revenue in UXON AI by firing purchase events with a numeric value from your eCommerce platform.
- The key requirement is that the UXON pixel is loaded before the purchase event fires.

## Source
- Help Center: [Track ecommerce revenue](https://docs.uxon.ai/en/articles/13543228-track-ecommerce-revenue)
- Source collection: Customer events and tracking / Revenue, ads, and troubleshooting

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
You can track eCommerce revenue in UXON AI by firing purchase events with a numeric value from your eCommerce platform. The key requirement is that the UXON pixel is loaded before the purchase event fires.

### Track revenue with Shopify

Use Shopify's Customer Events to send purchase data to UXON AI.

1. Go to **Settings**, then **Customer Events** in Shopify.
2. Select **Add custom pixel**.
3. Name the pixel, for example *UXON AI Purchase*.
4. Paste the code below using your real `PIXEL_ID`
5. Save and connect the pixel.

```text
// UXON AI - Shopify Custom Pixel
const UXON_SITE_ID = "YOUR_UXON_SITE_ID"; // e.g. "1ozg61"
window.uxon =
 window.uxon ||
 function () {
 (window.uxon.q = window.uxon.q || []).push(arguments);
 };
// Load UXON once
(function loadUxon() {
 if (window.__uxonLoaded) return;
 window.__uxonLoaded = true;
 const s = document.createElement("script");
 s.async = true;
 s.src = `https://uxon.ai/pixel/${encodeURIComponent(UXON_SITE_ID)}.js`;
 (document.head || document.body).appendChild(s);
})();
// Page views: use Shopify event, but skip the first one (UXON auto-PageView already covers it)
let seenFirstPageViewed = false;
analytics.subscribe("page_viewed", () => {
 if (!seenFirstPageViewed) {
 seenFirstPageViewed = true;
 return;
 }
 window.uxon("track", "PageView");
});
// Purchase: total charged
analytics.subscribe("checkout_completed", (event) => {
 const checkout = event?.data?.checkout;
 const rawAmount = checkout?.totalPrice?.amount;
 const value =
 typeof rawAmount === "number" ? rawAmount : parseFloat(rawAmount || "0");
 const currency =
 checkout?.currencyCode || checkout?.totalPrice?.currencyCode || "USD";
 window.uxon("track", "Purchase", {
 value: Number.isFinite(value) ? value : 0,
 currency,
 });
});
```

Once connected, Shopify will fire the purchase event with revenue data, which UXON AI uses for reporting. **The above code will also track page views and sessions across the site.**

> **How to find your pixel ID?** Navigate to **Customer Events** and copy the Pixel ID value. In the example below the pixel ID is `Ynxg6a` ```text ```

### Track revenue on other eCommerce platforms

For non-Shopify platforms, the setup follows the same core principles.

1. Ensure the **UXON pixel** is loaded on the page where the purchase completes.
2. Fire a purchase or conversion event at the moment checkout is completed.
3. Include a numeric `value` in the event payload to represent revenue.

Example:

```text
uxon('track', 'Purchase', { value: 199.00, currency: 'USD' });
```

#### Notes

- `value` must be a number, it is used to calculate revenue totals.
- `currency` is optional and stored as event data only, UXON AI does not perform currency conversion.
- The event is only recorded if the UXON pixel is running on the page where the purchase happens.
