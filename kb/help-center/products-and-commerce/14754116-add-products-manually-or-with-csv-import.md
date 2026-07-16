# Add products manually or with CSV import

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Create products one by one or bulk import a CSV to build your catalog faster.
- If you are not importing from a connected store, you can still build a complete catalog in UXON using manual entry or CSV import.
- Choose the right method **Add Product**: best when you are creating one product quickly.

## Source
- Help Center: [Add products manually or with CSV import](https://docs.uxon.ai/en/articles/14754116-add-products-manually-or-with-csv-import)
- Source collection: Products and commerce

## Related UXON Guides
- [Quick start](../../../QUICKSTART.md)
- [Agent command playbook](../../../SKILLS.md)

## Article
If you are not importing from a connected store, you can still build a complete catalog in UXON using manual entry or CSV import.

## Choose the right method

- **Add Product**: best when you are creating one product quickly.
- **Import CSV**: best for bulk uploads and recurring catalog updates.

## Add a product manually

1. Go to **Dashboard** -> **Products**.
2. Select **Add Product**.
3. Open product details and update title, variants, pricing, images, and checkout links.

## Import products with CSV

1. On Products page, select **Import CSV**.
2. Select **Choose CSV to upload** and upload your file.
3. Optionally select **Download example** to use the template.
4. Select **Import CSV**.

## CSV columns

Required columns for each row:

- **title**
- **variant_name**
- **price**
- **currency**

Useful optional columns:

- **option_1_name**, **option_1_value** (and option 2/3 equivalents)
- **checkout_url** to send traffic to the correct purchase destination
- **image_url** for variant visuals
- **available** (for example true/false)
- **source_variant_id** for stable update mapping across imports

## What to expect after CSV import

UXON shows a summary with items **added** and **updated**. You can re-import with improved CSV data as your catalog evolves.

## Troubleshooting

**Import says no valid rows found.**

- Check required columns and confirm each row includes product and variant values.

**Upload is blocked.**

- Use a valid **.csv** file and try again.
