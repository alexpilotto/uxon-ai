# What happens if you remove DNS records or move registrars?

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Remove DNS record or transfer domain.
- This explains what happens if you remove your DNS record or transfer your domain to a new registrar.
- If you remove or change the DNS record If the CNAME record is removed or changed, the domain can no longer be verified and your site will stop loading on that domain.

## Source
- Help Center: [What happens if you remove DNS records or move registrars?](https://docs.uxon.ai/en/articles/13542842-what-happens-if-you-remove-dns-records-or-move-registrars)
- Source collection: Publishing and domains

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Domains API](../../../skills/domains.md)
- [Connect a custom domain](../../domains/connect-custom-domain.md)

## Article
This explains what happens if you remove your DNS record or transfer your domain to a new registrar.

### If you remove or change the DNS record

If the CNAME record is removed or changed, the domain can no longer be verified and your site will stop loading on that domain.

Nothing is deleted. The site is simply disconnected from the domain.

### If you move your domain to a new registrar

If you transfer your domain to a new registrar, add the same CNAME record in the new registrar's DNS settings. Once the record is detected again, the domain reconnects automatically.

#### Notes

- No additional action is required inside the app.
- Reconnection happens automatically as soon as the correct DNS record is live.
