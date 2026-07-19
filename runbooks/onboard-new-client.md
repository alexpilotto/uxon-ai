# Onboard A New Client With UXON

Onboard a new client by creating a sub-account, setting conversion goals, creating the first landing page, connecting a domain, and configuring tracking.

## Inputs To Collect

- Client or business name.
- Website URL.
- Reporting currency, such as `USD`, `AUD`, or `GBP`.
- Reporting timezone when known, as an IANA timezone such as `Australia/Brisbane`. Do not add friction if unknown.
- Landing page feedback mode, usually `ai_approvals`.
- First conversion goal, such as `Qualified Lead`, `Phone Call`, or `Purchase`.
- Preferred publishing domain or subdomain.
- Tracking mode: `gtm` or `direct`.

Do not ask for brand colors, typography, voice, logo URL, or media assets during first setup unless the user volunteers them. UXON uses the website URL to start brand fetching, color/font assignment, and media scraping automatically.

## Command Sequence

### 1. Create The Sub-Account

```json
{
  "command": "subaccounts.create",
  "input": {
    "name": "Acme Dental",
    "websiteUrl": "https://acmedental.com",
    "reportingCurrency": "USD",
    "reportingTimezone": "Australia/Brisbane",
    "landingPageFeedbackMode": "ai_approvals"
  }
}
```

Save the returned `siteId`.

### 2. Create The First Goal

```json
{
  "command": "goals.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Qualified Lead",
    "isActive": true
  }
}
```

### 3. Create The First Blank Landing Page

```json
{
  "command": "landing_pages.create",
  "input": {
    "siteId": "site_uuid",
    "name": "Spring Offer"
  }
}
```

Use `landing_pages.generate_from_brief` instead when the user wants UXON AI to create the page from a brief.

### 4. Add The Domain

```json
{
  "command": "domains.add",
  "input": {
    "siteId": "site_uuid",
    "domain": "acmedental.com",
    "subdomain": "go"
  }
}
```

### 5. Connect The Domain

```json
{
  "command": "domains.connect",
  "input": {
    "domainId": "domain_uuid"
  }
}
```

### 6. Configure Tracking

```json
{
  "command": "tracking.setup",
  "input": {
    "siteId": "site_uuid",
    "mode": "gtm",
    "domain": "go.acmedental.com",
    "gtmContainerId": "GTM-ABC1234"
  }
}
```

## Done Criteria

- Sub-account exists.
- Brand/media import has been triggered from the website URL.
- At least one conversion goal exists.
- First landing page draft exists.
- Domain is added and DNS instructions are available or verified.
- Tracking mode is configured for the intended domain.
- Next step is clear: build page content, publish when approved, or launch an experiment.
