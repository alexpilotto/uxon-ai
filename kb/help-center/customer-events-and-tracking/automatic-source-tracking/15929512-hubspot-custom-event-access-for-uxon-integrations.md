# HubSpot custom event access for UXON integrations

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Why HubSpot event logging can be disabled and when to use profile-property mapping instead.
- UXON can send form submissions to HubSpot in two ways: as a HubSpot event, or by writing mapped values to contact profile properties.
- Recommended: log each submission as a HubSpot event Event logging keeps each form submission as activity history on the HubSpot contact.

## Source
- Help Center: [HubSpot custom event access for UXON integrations](https://docs.uxon.ai/en/articles/15929512-hubspot-custom-event-access-for-uxon-integrations)
- Source collection: Customer events and tracking / Automatic source tracking

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
UXON can send form submissions to HubSpot in two ways: as a HubSpot event, or by writing mapped values to contact profile properties.

## Recommended: log each submission as a HubSpot event

Event logging keeps each form submission as activity history on the HubSpot contact.

This is usually the best option because it avoids overwriting contact profile fields when the same person submits more than one form.

For this option to work, the connected HubSpot account must grant UXON custom event access during HubSpot connection.

## Fallback: create or update profile properties

Profile-property mapping writes selected form values directly to HubSpot contact properties.

This is useful when custom events are not available on the connected HubSpot account, but it can overwrite existing contact values if a later submission contains different answers.

## Why event logging may be disabled

HubSpot controls which API permissions are granted during connection.

Some HubSpot accounts can connect normally but cannot grant the custom event permissions UXON needs for event logging.

When this happens:

- HubSpot can still stay connected.
- Profile-property mapping can still be used.
- Event logging stays disabled until HubSpot grants custom event access.

## What to do if event logging is disabled

Use one of these options:

1. Use **Create/update profile properties** in the HubSpot action.
2. Reconnect HubSpot using an account that has access to HubSpot custom events.
3. Ask your HubSpot admin to confirm whether custom events via API are available on your HubSpot plan.

## What UXON asks HubSpot for

UXON asks HubSpot for normal contact permissions so the integration can create or find contacts.

UXON also asks for custom event permissions as optional access.

If HubSpot grants them, UXON enables event logging. If HubSpot does not grant them, UXON keeps the connection available for the profile-property flow.
