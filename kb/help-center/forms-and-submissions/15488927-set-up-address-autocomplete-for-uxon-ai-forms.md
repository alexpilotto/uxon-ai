# Set up address autocomplete for UXON AI forms

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Save reusable Google Places or Mapbox keys and enable address suggestions in UXON AI forms.
- Use geolocation API keys when you want address fields in UXON AI forms to suggest addresses as visitors type.
- UXON AI supports Google Places and Mapbox.

## Source
- Help Center: [Set up address autocomplete for UXON AI forms](https://docs.uxon.ai/en/articles/15488927-set-up-address-autocomplete-for-uxon-ai-forms)
- Source collection: Forms and submissions

## Related UXON Guides
- [Contacts API](../../../skills/contacts.md)
- [Conversion tracking API](../../../skills/conversion-tracking.md)

## Article
Use geolocation API keys when you want address fields in UXON AI forms to suggest addresses as visitors type.

UXON AI supports Google Places and Mapbox.

## Add reusable geolocation keys

1. Go to **Dashboard** > **Account** > **Settings**.
2. Find **Geolocation API** below **AI API Key (OpenAI)**.
3. Paste your **Google Places API key** or **Mapbox access token**.
4. Select **Save keys**.

These keys are saved for the current client account. New forms can use them without entering the key again.

## Enable autocomplete on a form

1. Open **Dashboard** > **Forms**.
2. Open the form you want to edit.
3. Open **Form settings**.
4. In **Integrations**, choose **Google Places** or **Mapbox** as the address autocomplete provider.
5. Save and publish the form.

If the form does not have its own key, UXON AI uses the reusable key from Account settings.

## Override the reusable key for one form

Use a form-specific key when one form needs a different Google Places key or Mapbox token.

1. Open the form.
2. Open **Form settings** > **Integrations**.
3. Choose the provider.
4. Paste the key into the provider key field.
5. Save and publish the form.

The form-specific key takes priority over the reusable Account settings key.

## What visitors see

When autocomplete is enabled, visitors can choose a suggested address.

They can also select **Enter address manually** under the address field. After an autocomplete address is selected, UXON AI shows the address subfields so the visitor can review and adjust the details before submitting.

## Recommended key setup

For Google Places, use a browser API key that is allowed to use the Places API.

For Mapbox, use a public access token.

Restrict keys to the domains where your forms are published. This reduces misuse if a browser key is copied from a public page.

## Troubleshooting

**Suggestions do not appear.**

- Confirm the correct provider is selected in **Form settings** > **Integrations**.
- Confirm a reusable key is saved in **Account** > **Settings** > **Geolocation API**, or add a form-specific key.
- Check that the key is active with Google Places or Mapbox.
- Check that domain restrictions include the page where the form is published.
- Save and publish the form after changing the provider or form-specific key.
