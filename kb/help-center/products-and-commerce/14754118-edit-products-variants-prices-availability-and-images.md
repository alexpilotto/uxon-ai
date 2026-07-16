# Edit products, variants, prices, availability, and images

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Use Product details to control catalog presentation and conversion readiness.
- Open any product in **Products** to manage how it appears and performs across your landing pages.
- Go to **Dashboard** -> **Products**.

## Source
- Help Center: [Edit products, variants, prices, availability, and images](https://docs.uxon.ai/en/articles/14754118-edit-products-variants-prices-availability-and-images)
- Source collection: Products and commerce

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Conversion tracking API](../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../examples/curl/setup-tracking.sh)

## Article
Open any product in **Products** to manage how it appears and performs across your landing pages.

## Open product details

1. Go to **Dashboard** -> **Products**.
2. Select the product row or use **Open details** from row actions.

## Edit product title

Select the title at the top of the details page, update it, and save by pressing Enter or clicking outside the field.

## Manage variant options

- Use **Add option** to create option groups (for example Size or Color).
- Use **Edit** to rename options and adjust values.
- Use **Remove** to delete unused options.

For Shopify-sourced products, option editing is locked inside UXON.

## Update the variant matrix

In **Variant matrix**, update each variant as needed:

- Variant name
- Price
- Checkout URL (editable for WooCommerce/manual products)
- Availability via variant actions (**Enable**/**Disable**)

## Manage variant images

Use the image action menu on each variant to:

- **Upload** an image file
- **Import** from an image URL
- **Delete** the current image

## Remove a product

Use the top-right **Delete** button (or **Remove** in row actions) and confirm to remove the product from your catalog.

## Troubleshooting

**Some fields are locked.**

- Shopify-sourced products keep specific source-managed fields read-only in UXON.

**Changes do not appear in builder.**

- Refresh your editor view after saving product updates.
