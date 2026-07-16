# Link buttons and menu items to page sections

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Create smooth on-page navigation so visitors jump directly to pricing, FAQ, or CTA sections.
- Use anchor links to send visitors to the exact section they need, like pricing, testimonials, or FAQs.
- Step 1: Set the target section ID 1.

## Source
- Help Center: [Link buttons and menu items to page sections](https://docs.uxon.ai/en/articles/14754408-link-buttons-and-menu-items-to-page-sections)
- Source collection: Builder overview / Buttons, links, and conversion actions

## Related UXON Guides
- [Landing pages API](../../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../../landing-pages/import-code-pages.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)

## Article
Use anchor links to send visitors to the exact section they need, like pricing, testimonials, or FAQs.

## Step 1: Set the target section ID

1. Select the section you want visitors to jump to.
2. Open **Section settings**.
3. Find **Section ID** and enter a clear value, for example **pricing** or **faq**.

Use simple lowercase words with dashes (for example **customer-proof**).

## Step 2: Link your CTA or navigation item

1. Select the button or navigation item that should trigger the jump.
2. In its **Link** field, enter **#** plus your Section ID (for example **#pricing**).
3. Save changes.

## Step 3: Test in preview

1. Enable **Interact with preview** in the top bar.
2. Click the link/button and confirm it jumps to the right section.
3. Repeat in **Mobile preview**.

> Anchor links are excellent for long landing pages where users need quick access to pricing, proof, or FAQs.

## Troubleshooting

**The link does not jump to the section.**

- Check the link starts with **#** and exactly matches the **Section ID**.

**I do not see a Section ID field.**

- Use a section/template that supports **Section ID** and retest the anchor link.
