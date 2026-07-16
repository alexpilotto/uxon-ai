# Import products from Shopify and WooCommerce

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Connect your store and import the products and variants you want to use on UXON landing pages.
- Use the **Products** page to import catalog data from Shopify or WooCommerce, then use those products across your landing pages and offer blocks.
- Before you import Work from the correct UXON client account.

## Source
- Help Center: [Import products from Shopify and WooCommerce](https://docs.uxon.ai/en/articles/14754115-import-products-from-shopify-and-woocommerce)
- Source collection: Products and commerce

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)

## Article
Use the **Products** page to import catalog data from Shopify or WooCommerce, then use those products across your landing pages and offer blocks.

## Before you import

- Work from the correct UXON client account.
- Have your store website URL ready.
- Make sure your storefront is publicly accessible so UXON can read product data.

## Start the import flow

1. Go to **Dashboard** -> **Products**.
2. Select **Import**.
3. Choose **Shopify** or **WooCommerce**.
4. Enter your **Website URL** and select **Connect Shopify store** or **Connect WooCommerce store**.

## Choose products and variants

After connection, UXON shows an import list with products and variant checkboxes.

- Use **Search products** to filter quickly.
- Select the exact variants you want to bring in.
- Review the selection counter, then select **Add**.

You will see an import summary showing how many items were added and how many existing items were updated.

## What happens after import

- Imported products appear in your Products table with source badges.
- Each product opens in **Open details** for pricing, variant, image, and checkout-link updates.
- Connected products can be refreshed later to sync store updates.

## Troubleshooting

**No products found after connecting.**

- Confirm the website URL points to the live store.
- For Shopify, remove storefront password protection before importing.

**Connection fails.**

- Check URL format and try the store root domain.
- Make sure the store exposes a public product feed.
