# Add click-to-call buttons with automatic call tracking

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Set button links with the {{phone}} variable so visitors can call the tracked number without manual updates.
- If you run call campaigns, this setup lets your landing page buttons automatically use your tracked phone number.
- Where to configure your call button 1.

## Source
- Help Center: [Add click-to-call buttons with automatic call tracking](https://docs.uxon.ai/en/articles/14754558-add-click-to-call-buttons-with-automatic-call-tracking)
- Source collection: Builder overview / Buttons, links, and conversion actions

## Related UXON Guides
- [Landing pages API](../../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../../landing-pages/import-code-pages.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)

## Article
If you run call campaigns, this setup lets your landing page buttons automatically use your tracked phone number.

## Where to configure your call button

1. Open your landing page in Builder.
2. Select the button element you want to use for calls.
3. Open **Element settings**.

## Set the button link to your tracked number

1. In the button **Link** field, enter `###{{phone}}`.
2. Save your changes.
3. Test in preview using **Interact mode**.

When call tracking is active, UXON can replace this value with the correct tracking number.

## Best practice for call CTAs

- Use clear CTA text like **Call now** or **Speak to an expert**.
- Place call CTAs high on mobile layouts.
- Test from mobile preview before going live.

> Using `###{{phone}}` helps you keep buttons consistent when tracking numbers change.

## Troubleshooting

**The call button does not use my tracking number.**

- Confirm call tracking is enabled for your workspace and the button link contains `###{{phone}}` exactly.

**Button click does nothing in preview.**

- Enable **Interact mode** and retest the button.
