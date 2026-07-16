# Domains API

Manage connected domains and subdomains for UXON landing pages and attribution workflows.

## Core Commands

- `domains.list`: list domains for one sub-account.
- `domains.add`: add a root domain or subdomain.
- `domains.connect`: run DNS verification and update domain connection status.

## List Domains

```json
{
  "command": "domains.list",
  "input": {
    "siteId": "site_uuid"
  }
}
```

## Add A Domain

```json
{
  "command": "domains.add",
  "input": {
    "siteId": "site_uuid",
    "domain": "example.com",
    "subdomain": "www"
  }
}
```

## Connect A Domain

```json
{
  "command": "domains.connect",
  "input": {
    "domainId": "domain_uuid"
  }
}
```

## Agent Safety

Domain setup may require DNS changes outside UXON. Agents should explain the DNS step, wait for the operator or developer to update records, then run `domains.connect` again.

## Related Files

- [Conversion tracking](conversion-tracking.md)
- [Onboard new client runbook](../runbooks/onboard-new-client.md)
