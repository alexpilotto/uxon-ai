# Manage checkout links across product sources

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Set reliable destination URLs so each selected variant can convert correctly.
- Checkout links control where visitors go next after selecting a product on your landing page experience.
- Keep them accurate to avoid lost conversions.

## Source
- Help Center: [Manage checkout links across product sources](https://docs.uxon.ai/en/articles/14754119-manage-checkout-links-across-product-sources)
- Source collection: Products and commerce

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)

## Article
Checkout links control where visitors go next after selecting a product on your landing page experience. Keep them accurate to avoid lost conversions.

## Checkout link behavior by product source

| Source | How checkout links work |
| --- | --- |
| **Shopify** | Checkout links are generated from Shopify data and are read-only in product details. |
| **WooCommerce** | Links are imported from store data and can be edited in UXON when needed. |
| **Manual / CSV** | You control checkout links directly in UXON for every variant. |

## Update checkout links

1. Go to **Products** and open product details.
2. In **Variant matrix**, edit the **Checkout URL** field for each variant.
3. Confirm availability is enabled for variants you want to use.

## Why links affect product selection in builder

In the product picker, a variant is only selectable when it is marked available and has a non-empty checkout link. If either is missing, that option cannot be selected for page content.

## Pre-launch quality check

- Open each priority product and test checkout URLs manually.
- Refresh connected products before major campaign launches.
- Re-check links after major product or storefront updates.

## Troubleshooting

**Variant is missing in product picker.**

- Add a checkout link and enable the variant, then reopen the picker.

**Shopify checkout link cannot be edited.**

- This is expected. Update the source variant in Shopify, then refresh in UXON.
