# Set up Google Ads enhanced conversions for UXON AI forms and Contact forms with Google Tag Manager

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Import a GTM template that maps UXON AI form contact data to enhanced conversions.
- Use this guide when you want Google Tag Manager to send UXON AI form or LP builder Contact form details to Google Ads enhanced conversions.
- UXON AI forms push uxon_form_submit and LP builder Contact forms push lead.

## Source
- Help Center: [Set up Google Ads enhanced conversions for UXON AI forms and Contact forms with Google Tag Manager](https://docs.uxon.ai/en/articles/15676265-set-up-google-ads-enhanced-conversions-for-uxon-ai-forms-and-contact-forms-with-google-tag-manager)
- Source collection: Forms and submissions

## Related UXON Guides
- [Contacts API](../../../skills/contacts.md)
- [Conversion tracking API](../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../examples/curl/setup-tracking.sh)

## Article
Use this guide when you want Google Tag Manager to send UXON AI form or LP builder Contact form details to Google Ads enhanced conversions. UXON AI forms push `uxon_form_submit` and LP builder Contact forms push `lead`. Both events include the same stable `contact_` fields, so PPC teams do not need to manually create each data layer variable.

> Download Google Ads - Enhanced Conversion tracking GTM template [here](#h_c354119de3)

## Before you start

- Google Tag Manager must be installed on the page where the form is submitted.
- For UXON AI forms, **Enable data layer events** must be turned on. This is enabled by default.
- You need access to the Google Tag Manager container used for the landing page or form page.
- Your Google Ads conversion action should be ready for enhanced conversions.

## What the template adds

The template imports these GTM items:

- A custom event trigger for `uxon_form_submit` or `lead`
- Data layer variables for `contact_email`, `contact_phone`, `contact_first_name`, `contact_last_name`, `contact_full_name`, `contact_postal_code`, and `contact_country`
- A Google Ads User-Provided Data variable called `UXON AI - Google Ads User-Provided Data`
- A helper tag that sets Google `user_data` from the form submission event

## Import the template

1. Open Google Tag Manager.
2. Open the container used on your UXON AI landing page or form page.
3. Go to **Admin** -> **Import Container**.
4. Choose the UXON AI enhanced conversions JSON file.
5. Choose the current workspace or create a new workspace.
6. Choose **Merge**, then select **Rename conflicting tags, triggers, and variables** if GTM shows a conflict warning.
7. Review the imported items, then confirm the import.

## Connect your Google Ads conversion tag

If your Google Ads conversion tag is already in GTM, open that tag and enable enhanced conversions. Choose manual setup and select `UXON AI - Google Ads User-Provided Data` as the user-provided data variable.

If UXON AI is firing your Google Ads conversion directly, keep the imported helper tag enabled. It sets Google `user_data` when the form submit event enters the data layer, before the form conversion event is fired.

## Validate in Preview mode

1. Open GTM Preview mode.
2. Submit a test UXON AI form or LP builder Contact form.
3. Select the submit event in the preview timeline: `uxon_form_submit` for UXON AI forms or `lead` for LP builder Contact forms.
4. Confirm the UXON AI contact variables are populated.
5. Confirm your Google Ads conversion tag or UXON AI helper tag fires on the form submit event.

## Data layer keys

| GTM variable | Data layer key |
| --- | --- |
| UXON AI - Contact Email | `contact_email` |
| UXON AI - Contact Phone | `contact_phone` |
| UXON AI - Contact First Name | `contact_first_name` |
| UXON AI - Contact Last Name | `contact_last_name` |
| UXON AI - Contact Full Name | `contact_full_name` |
| UXON AI - Contact Postal Code | `contact_postal_code` |
| UXON AI - Contact Country | `contact_country` |

## Important notes

- UXON AI still sends the existing form field keys such as `field_email` and `field_contact_number`. The fixed `contact_` keys are added for easier GTM mapping.
- LP builder Contact forms still send only the existing `lead` data layer event. The template also supports `uxon_form_submit` for UXON AI forms.
- Google Ads can use email or phone on their own. Name matching also needs postal code and country, so the template includes those fields when captured. These fields can be empty when the form does not collect them.
- The template does not publish your GTM workspace. Preview and publish the workspace only after your test submission works as expected.
- Follow your consent policy before sending user-provided data to advertising platforms.

## Troubleshooting

**The UXON AI variables are empty in GTM Preview.**

- Confirm the form was submitted successfully.
- For UXON AI forms, confirm **Enable data layer events** is on in the form tracking settings.
- Confirm the form has email, phone, or name fields available in the submission.

**The event does not appear in GTM Preview.**

- Confirm GTM is installed on the page where the form is submitted.
- Submit the form again after connecting Preview mode.

**Google Ads still reports no enhanced conversions.**

- Check that your Google Ads conversion action supports enhanced conversions.
- Confirm the correct conversion tag fires after the UXON AI form submit or lead event.
- Allow time for Google Ads diagnostics to update after testing.

## Download data layer template
