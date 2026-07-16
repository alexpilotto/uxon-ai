# Connect A Custom Domain

UXON can publish landing pages on a connected root domain or subdomain. Domain setup usually requires adding DNS records at the provider where the domain is managed. After DNS records are added, UXON verifies the domain and prepares it for publishing.

Source Help Center article: [How to connect your custom domain](https://docs.uxon.ai/en/articles/13541944-how-to-connect-your-custom-domain)

## Domain Types

UXON supports:

- Root domains, such as `example.com`.
- Subdomains, such as `go.example.com` or `lp.example.com`.

## API Commands

Add a domain:

```json
{
  "command": "domains.add",
  "input": {
    "siteId": "site_uuid",
    "domain": "example.com",
    "subdomain": "go"
  }
}
```

Verify and connect a domain:

```json
{
  "command": "domains.connect",
  "input": {
    "domainId": "domain_uuid"
  }
}
```

## Agent Guidance

Agents should not pretend DNS is complete. Ask the operator to add the records shown in UXON, then run `domains.connect` after the DNS change is made.

## Related Files

- [Domains API](../../skills/domains.md)
- [Onboard new client runbook](../../runbooks/onboard-new-client.md)
