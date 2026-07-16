# Add Google Tag Manager

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Add Google Tag Manager.
- You can add Google Tag Manager (GTM) to UXON AI landing pages using **Global Scripts**.
- GTM requires **two scripts**, one placed in the page head and one at the start of the body.

## Source
- Help Center: [Add Google Tag Manager](https://docs.uxon.ai/en/articles/13543261-add-google-tag-manager)
- Source collection: Global settings and scripts

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)

## Article
You can add Google Tag Manager (GTM) to UXON AI landing pages using **Global Scripts**. GTM requires **two scripts**, one placed in the page head and one at the start of the body.

### Add the GTM head script

1. Open **Global settings**.
2. Go to **Global Scripts**.
3. Select **Add Script**.
4. Fill in:**Script Name**, for example *Google Tag Manager Head*
5. **Script Placement**, select **Head**
6. **Script Code**, paste the GTM head snippet from Google
7. **Domains**, select at least one domain
8. Select **Add Script** to save.

### Add the GTM body script

1. Select **Add Script** again.
2. Fill in:**Script Name**, for example *Google Tag Manager Body*
3. **Script Placement**, select **Body Start**
4. **Script Code**, paste the GTM body snippet from Google
5. **Domains**, select the same domains
6. Select **Add Script** to save.

Both scripts must be enabled for Google Tag Manager to work correctly.

###

### Troubleshooting

**GTM is not firing**

- Confirm both GTM scripts are added and enabled.
- Confirm the correct domains are selected for each Global Script.

**Tags fire at the wrong time**

- Check that the head snippet uses **Head** placement.
- Check that the body snippet uses **Body Start** placement.
