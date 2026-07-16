# Conversion Tracking API

Set up first-party conversion tracking with UXON by configuring GTM or direct GA4/Meta tracking on a domain. UXON uses guardrails to avoid keeping GTM and direct IDs active together.

## Core Command

- `tracking.setup`: configure tracking safely in one command.

## GTM Mode

GTM mode installs managed GTM snippets in `head` and `body-start`, and clears direct GA4/Meta IDs to prevent duplicate firing.

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

## Direct GA4/Meta Mode

Direct mode disables managed GTM scripts on the selected domain and saves direct GA4 and/or Meta IDs.

```json
{
  "command": "tracking.setup",
  "input": {
    "siteId": "site_uuid",
    "mode": "direct",
    "domain": "www.example.com",
    "ga4MeasurementId": "G-PSW1MY7HB4",
    "metaPixelId": "123456789012345"
  }
}
```

## Agent Safety

Tracking changes affect live measurement. Agents should confirm the target domain and mode before calling `tracking.setup`.

## Related Files

- [Domains](domains.md)
- [Reports](reports.md)
- [Setup tracking example](../examples/curl/setup-tracking.sh)
