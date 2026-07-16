# Contacts API

Retrieve contacts and source context from UXON so agents can connect leads back to pages, variants, campaigns, and conversion events.

## Core Commands

- `reports.contacts.list`: list contacts with pagination and filters.
- `reports.contacts.detail`: fetch one contact profile and latest submission details.

## List Contacts

```json
{
  "command": "reports.contacts.list",
  "input": {
    "siteId": "site_uuid",
    "page": 1,
    "perPage": 25
  }
}
```

## Get Contact Detail

```json
{
  "command": "reports.contacts.detail",
  "input": {
    "siteId": "site_uuid",
    "contactId": "contact_uuid"
  }
}
```

## Agent Use Cases

- Summarize recent leads before a client call.
- Trace a conversion back to page and variant context.
- Compare lead quality against the page or campaign that generated it.

## Related Files

- [Reports](reports.md)
- [Conversion tracking](conversion-tracking.md)
