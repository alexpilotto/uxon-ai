# Set Up Enhanced Conversions With GTM

UXON forms and landing page contact forms can push stable contact fields into the data layer for Google Tag Manager. This lets PPC teams map form submissions into Google Ads enhanced conversions without manually creating every variable from scratch. Consent and advertising platform policies should still be followed before sending user-provided data.

Source note: based on the UXON Help Center GTM enhanced conversions article for forms and contact forms.

## Relevant Events

UXON form submissions can use:

- `uxon_form_submit` for UXON forms.
- `lead` for landing page builder contact forms.

Common contact fields include:

- `contact_email`
- `contact_phone`
- `contact_first_name`
- `contact_last_name`
- `contact_full_name`
- `contact_postal_code`
- `contact_country`

## Setup Pattern

1. Confirm GTM is installed on the page where the form is submitted.
2. Confirm data layer events are enabled for the form.
3. Create or import GTM variables for the stable `contact_` fields.
4. Configure the Google Ads user-provided data variable.
5. Fire the conversion tag on the form submit event.
6. Validate in GTM Preview mode before publishing the GTM workspace.

## Related UXON Command

Use `tracking.setup` when configuring tracking mode at the UXON domain level.

```json
{
  "command": "tracking.setup",
  "input": {
    "siteId": "site_uuid",
    "mode": "gtm",
    "domain": "www.example.com",
    "gtmContainerId": "GTM-ABC1234"
  }
}
```

## Related Files

- [Conversion tracking API](../../skills/conversion-tracking.md)
- [Setup tracking example](../../examples/curl/setup-tracking.sh)
