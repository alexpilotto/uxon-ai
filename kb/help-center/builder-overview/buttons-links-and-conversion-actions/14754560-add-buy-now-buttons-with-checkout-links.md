# Add buy-now buttons with checkout links

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Configure button actions to sell products directly from your landing page using connected catalog data.
- Use button sell actions to route visitors straight to product checkout from your landing page.
- Select a button element in Builder.

## Source
- Help Center: [Add buy-now buttons with checkout links](https://docs.uxon.ai/en/articles/14754560-add-buy-now-buttons-with-checkout-links)
- Source collection: Builder overview / Buttons, links, and conversion actions

## Related UXON Guides
- [Landing pages API](../../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../../landing-pages/import-code-pages.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)

## Article
Use button sell actions to route visitors straight to product checkout from your landing page.

## Set a button to sell mode

1. Select a button element in Builder.
2. Open **Element settings**.
3. Change **Button action** to **Sell**.
4. Select the product/variant from the product picker.
5. Save and test the checkout flow.

## Optional: set out-of-stock redirection

- Use **Out of stock redirection** to send visitors to an alternative page when needed.

## Conversion tips for buy-now CTAs

- Match button copy with the specific product offer.
- Keep pricing and offer context close to the button.
- Validate mobile click flow before launch.

> For ecommerce campaigns, a clear buy-now path usually converts better than sending users to a generic product list.

## Troubleshooting

**Sell option is not working.**

- Confirm a product variant is selected and available.

**Checkout link looks incorrect.**

- Refresh product/catalog data and reselect the variant.
