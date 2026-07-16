# Add UXON AI forms to landing pages

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Select a published form inside Landing Page Builder and keep embedded forms up to date.
- Published UXON AI forms can be selected inside landing page sections and opened from form buttons.
- Before you start Create the form in **Dashboard** > **Forms**.

## Source
- Help Center: [Add UXON AI forms to landing pages](https://docs.uxon.ai/en/articles/15391787-add-uxon-ai-forms-to-landing-pages)
- Source collection: Forms and submissions / Build and publish forms

## Related UXON Guides
- [Landing pages API](../../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../../landing-pages/import-code-pages.md)
- [Contacts API](../../../../skills/contacts.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)

## Article
Published UXON AI forms can be selected inside landing page sections and opened from form buttons.

## Before you start

- Create the form in **Dashboard** > **Forms**.
- Publish the form. Draft forms do not appear in landing page form selectors.
- Open the landing page or variant where the form should be used.

## Select a form in Landing Page Builder

1. Open the landing page in Builder.
2. Select the section or button setting that uses a form picker.
3. Select **Select form** or **Edit selection**.
4. Choose the published form.
5. Save or publish the landing page.

## How published form versions work

The landing page uses a published form version. This keeps the form stable for visitors after the page is saved.

## Update an embedded form after form changes

1. Edit the form in **Dashboard** > **Forms**.
2. Select **Save** or **Publish** in Form Builder.
3. Open the landing page that uses the form.
4. Reopen the form picker, confirm the form selection, then save or publish the landing page.

> If you update a form but do not update the landing page, the page may continue using the older embedded form version.

## Troubleshooting

**The form picker is empty.**

- Publish at least one form in **Dashboard** > **Forms**.

**The selected form says it is not published or no longer exists.**

- Check that the form still exists and has **Published** status.
