# Refresh product data and sync your catalog

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Refresh connected catalog products so pricing and availability stay current.
- Use refresh to pull updated catalog data from connected Shopify and WooCommerce sources without rebuilding products from scratch.
- When refresh is available Refresh is available for products imported from **Shopify** and **WooCommerce**.

## Source
- Help Center: [Refresh product data and sync your catalog](https://docs.uxon.ai/en/articles/14754117-refresh-product-data-and-sync-your-catalog)
- Source collection: Products and commerce

## Related UXON Guides
- [Quick start](../../../QUICKSTART.md)
- [Agent command playbook](../../../SKILLS.md)

## Article
Use refresh to pull updated catalog data from connected Shopify and WooCommerce sources without rebuilding products from scratch.

## When refresh is available

- Refresh is available for products imported from **Shopify** and **WooCommerce**.
- Manual and CSV-only products do not have source refresh.

## Refresh all connected products

1. Go to **Dashboard** -> **Products**.
2. Select the **Refresh imported products** icon in the header.
3. Wait for completion, then review updated rows.

## Refresh one product

You can refresh a single product from:

- Row actions in the Products table (**Refresh**).
- Product details page using the top-right **Refresh** button.

## What refresh updates

- Current pricing and currency
- Variant availability
- Checkout link data from the source store
- Recent catalog changes, depending on source and variant mapping

> Best practice: run refresh before launching or scaling paid traffic so landing page offers match the latest store data.

## Troubleshooting

**No connected catalog products available to refresh.**

- Import at least one Shopify or WooCommerce product first.

**A product could not be refreshed.**

- Confirm the product still exists in the source store and remains publicly accessible.
