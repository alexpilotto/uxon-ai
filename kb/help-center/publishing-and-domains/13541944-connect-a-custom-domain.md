# Connect a custom domain

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Point your domain or subdomain to UXON using a DNS CNAME record.
- Connecting a custom domain takes a few minutes and only requires adding **one DNS record**.
- You can connect either a root domain (example.com) or a subdomain (lp.example.com).

## Source
- Help Center: [Connect a custom domain](https://docs.uxon.ai/en/articles/13541944-connect-a-custom-domain)
- Source collection: Publishing and domains

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Domains API](../../../skills/domains.md)
- [Connect a custom domain](../../domains/connect-custom-domain.md)

## Article
Connecting a custom domain takes a few minutes and only requires adding **one DNS record**. You can connect either a root domain (`example.com`) or a subdomain (`lp.example.com`).

### Step 1. Open your DNS settings

Log in to the provider where you purchased your domain and open your DNS settings. This may be labelled DNS, DNS Management, or Advanced DNS.

### Step 2. Add the CNAME record

Create new DNS record(s) using the values shown in the UXON app.

If connecting a **root domain** (`example.com`), add **two A records**:

- Type: **A**
- Host: **@** (or blank/root depending on your provider)
- Value: copy each **Value** shown in UXON
- TTL: leave unchanged

If connecting a subdomain (`lp.example.com`), add one CNAME record:

- Type: **CNAME**
- Host: copy the **Host** value shown
- Value: copy the **Value** shown
- TTL: leave unchanged

Save the record(s).

###

> DNS changes can take up to **24-48 hours**, though they often propagate sooner. Once the record is detected, the domain connects automatically and you'll receive a confirmation email.
