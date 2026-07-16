# Add custom JavaScript to your landing pages

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Add custom JavaScript to pages.
- You can add custom JavaScript to UXON AI landing pages either on a single page or across multiple pages using Global Scripts.
- UXON AI supports two approaches, page-level JavaScript for one landing page, and Global Scripts for code that should run across multiple pages or domains.

## Source
- Help Center: [Add custom JavaScript to your landing pages](https://docs.uxon.ai/en/articles/13543254-add-custom-javascript-to-your-landing-pages)
- Source collection: Global settings and scripts

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)

## Article
You can add custom JavaScript to UXON AI landing pages either on a single page or across multiple pages using Global Scripts. UXON AI supports two approaches, page-level JavaScript for one landing page, and Global Scripts for code that should run across multiple pages or domains.

### Add JavaScript to a single landing page

Use this when the code should run on only one landing page.

1. Open the landing page in the editor.
2. Select **Code** in the left toolbar.
3. Under **Custom code**, open the **JavaScript** tab.
4. Paste your JavaScript directly, do not include a `` wrapper.
5. Select **Save** to publish the change.

If the script throws an error, the builder preview may show *Custom code error*, which indicates a runtime issue in the script.

### Add JavaScript across pages using Global Scripts

Use this when the same JavaScript should run across multiple pages or domains, such as analytics, tracking pixels, chat widgets, or tag managers.

1. Open **Global settings**.
2. Go to **Global Scripts**.
3. Select **Add Script**.
4. Fill in **Script Name**, **Script Placement**, and **Script Code**.
5. Select at least one option under **Domains**.
6. Select **Add Script** to save.

Global Scripts will not save unless at least one domain is selected.

### Troubleshooting

**If a script is saved but not running:**

- Confirm the landing page was saved for page-level JavaScript.
- Confirm the Global Script is enabled and the correct domains are selected.

**If a script runs at the wrong time:**

- Adjust **Script Placement** to Head, Body Start, or Body End.
