# Add HTML scripts to your landing pages

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Add scripts using Global Scripts or the page Code panel.
- You can add scripts to UXON AI landing pages using **Global Scripts** for domain-wide third party tags, or the **Code panel** in the page builder for per-page JavaScript and CSS.
- Add scripts across your connected domains with Global Scripts Use this option when you have a vendor snippet like analytics, chat widgets, or A/B testing that should load on pages served from specific domains.

## Source
- Help Center: [Add HTML scripts to your landing pages](https://docs.uxon.ai/en/articles/13543257-add-html-scripts-to-your-landing-pages)
- Source collection: Global settings and scripts

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)

## Article
You can add scripts to UXON AI landing pages using **Global Scripts** for domain-wide third party tags, or the **Code panel** in the page builder for per-page JavaScript and CSS.

### Add scripts across your connected domains with Global Scripts

Use this option when you have a vendor snippet like analytics, chat widgets, or A/B testing that should load on pages served from specific domains.

1. Open **Global settings** from the dashboard sidebar.
2. Select **Global Scripts**, then click **Add Script**.
3. Fill in the required fields:**Script Name**
4. **Script Placement**, choose Head, Body Start, or Body End
5. **Script Code**, paste your JavaScript snippet, you can include a full `...` block
6. **Domains**, select at least one connected domain
7. Select **Add Script** or **Update Script** to save.
8. Use the script's menu to **Enable Script** or **Disable Script** as needed.

#### **Important notes**

- Domains are required, scripts will not save unless at least one domain is selected.
- Script Code is treated as a script, UXON AI normalizes your input into a `` tag.
- Do not paste non-script HTML like ``, ``, or `` into Script Code.

### Add per-page JavaScript and CSS in the landing page builder

Use this option when the code should apply only to a single landing page or variant.

1. Open the landing page editor.
2. Select **Code** in the left toolbar.
3. Add your code in the appropriate tab:**CSS** for styles
4. **Javascript** for page scripts

#### **Notes**

- The Javascript tab expects raw JavaScript, not a `...` wrapper.
- If your JavaScript throws an error in the editor preview, UXON AI may surface it as **"Custom code error: ..."**, which helps you debug issues early.
