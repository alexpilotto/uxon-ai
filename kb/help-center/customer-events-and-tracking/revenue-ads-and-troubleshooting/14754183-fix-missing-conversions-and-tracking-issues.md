# Fix missing conversions and tracking issues

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Resolve common Event Auto-Capture issues quickly and restore reliable conversion tracking.
- If Event Auto-Capture is enabled but events are not appearing as expected, use this checklist to isolate and fix the issue quickly.
- Issue: status is Not connected Open the source in **Event Auto-Capture** and confirm it is enabled.

## Source
- Help Center: [Fix missing conversions and tracking issues](https://docs.uxon.ai/en/articles/14754183-fix-missing-conversions-and-tracking-issues)
- Source collection: Customer events and tracking / Revenue, ads, and troubleshooting

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
If Event Auto-Capture is enabled but events are not appearing as expected, use this checklist to isolate and fix the issue quickly.

## Issue: status is Not connected

- Open the source in **Event Auto-Capture** and confirm it is enabled.
- Run one real conversion action (for example form completion or checkout completion).
- If using Shopify, verify the latest copied code is installed in Shopify Customer Events.

## Issue: status is Connection issue

- Open **Edit configuration**, review mapping, and save again.
- Recheck the source integration in the platform itself.
- Run a fresh conversion action to confirm recovery.

## Issue: conversions happened but events are missing

- Confirm the event source is enabled and mapped to the expected event name.
- Check your event filters in reporting so the mapped name is included.
- If conversion occurs off-site, ensure domain is added in **Domain Whitelisting**.
- Verify pixel presence with **Tracking Pixel** -> **Verify Installation**.

## Issue: revenue is not attached

- For Shopify, ensure **Capture revenue data** is enabled in configuration.
- Check that your checkout event includes order amount.
- Review **Reporting currency** in Pixel settings.

> If you track the same action with both manual custom events and auto-capture, reporting can be inflated. Use one primary method per conversion action.

## When to escalate

If status remains in **Connection issue** after reconfiguration and a fresh test event, capture screenshots of your setup and contact UXON support for deeper investigation.
