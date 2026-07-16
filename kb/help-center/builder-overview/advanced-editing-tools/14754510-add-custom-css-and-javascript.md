# Add custom CSS and JavaScript

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Use the Code panel to add custom styling and scripts to your landing page when you need advanced control.
- When standard Builder controls are not enough, you can add custom CSS and JavaScript directly from the **Code** panel.
- In the left toolbar, click **Code** (square code icon).

## Source
- Help Center: [Add custom CSS and JavaScript](https://docs.uxon.ai/en/articles/14754510-add-custom-css-and-javascript)
- Source collection: Builder overview / Advanced editing tools

## Related UXON Guides
- [Landing pages API](../../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../../landing-pages/import-code-pages.md)

## Article
When standard Builder controls are not enough, you can add custom CSS and JavaScript directly from the **Code** panel.

## Open custom code in Builder

1. Open your landing page in Builder.
2. In the left toolbar, click **Code** (square code icon).
3. Use the **CSS** and **Javascript** tabs to add your code.

## What to use CSS and JavaScript for

- **CSS**: fine visual tweaks not covered by default settings.
- **Javascript**: lightweight behavior enhancements and page interactions.

## Safe workflow for custom code

1. Add one small change at a time.
2. Save and test in preview after each change.
3. Check Desktop and Mobile before finalizing.

> If a script causes issues, remove the last change and retest. Incremental edits are easier to debug.

## Troubleshooting

**The page looks broken after adding code.**

- Undo the latest custom code change and reintroduce updates in smaller steps.

**My custom behavior is not working as expected.**

- Verify selectors and logic against the current section structure, then retest in preview.
