# Fire third-party conversion scripts from UXON AI Lead events

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Send Meta, Google Ads, LinkedIn, OpenAI, or other platform conversion events when UXON AI records a Lead.
- Use custom conversion tracking scripts when you want another advertising or analytics platform to receive a conversion event when UXON AI records a Lead.
- When to use custom conversion scripts This is useful when a platform needs its own event call after a successful lead submission, and you are not using Google Tag Manager.

## Source
- Help Center: [Fire third-party conversion scripts from UXON AI Lead events](https://docs.uxon.ai/en/articles/15813402-fire-third-party-conversion-scripts-from-uxon-ai-lead-events)
- Source collection: Customer events and tracking / Core tracking setup and controls

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Use custom conversion tracking scripts when you want another advertising or analytics platform to receive a conversion event when UXON AI records a Lead.

## When to use custom conversion scripts

This is useful when a platform needs its own event call after a successful lead submission, and you are not using Google Tag Manager.

Common examples include Meta, Google Ads, LinkedIn, OpenAI, or another platform that gives you an event snippet.

## Before you start

- Install the platform base pixel or global script on the page first. The event script normally depends on that base script.
- For UXON AI landing pages, add base pixels in **Global Scripts** when they should load on UXON-hosted pages.
- For an external root domain, install the platform base pixel directly on that site as well.
- Make sure the UXON pixel is present wherever UXON should record the Lead event.

## Add a conversion tracking block

1. Go to **Customer Events**.
2. Open the **Lead** event installation details.
3. In **Conversion tracking**, keep Google Ads configured if you use it.
4. Select **Add conversion tracking** for another platform.
5. Give the block a clear name, such as **Meta - Lead** or **LinkedIn - Lead event**.
6. Paste the platform event script.
7. Enable the block when it is ready to fire.

## Script examples

You can paste a full script tag or the raw JavaScript event call. UXON AI normalizes the script before firing it.

**Meta Lead event**

```text
fbq('track', 'Lead');
```

**Google Ads conversion**

```text
gtag('event', 'conversion', { send_to: 'AW-CONVERSION_ID/CONVERSION_LABEL' });
```

**LinkedIn conversion**

```text
window.lintrk('track', { conversion_id: 123456 });
```

## Use UXON AI landing page scope

Enable **Fire only on UXON AI landing pages** when you only want the platform conversion to fire from UXON-hosted landing pages.

This helps prevent duplicate conversions when the same platform pixel or conversion logic also runs on the root website.

Example: if a visitor submits a form on `root.com/contact` and UXON records it as a Lead, the custom platform script should only fire there when that tracking block is allowed to run outside UXON AI landing pages.

## Important notes

- The custom event script only works if the platform function already exists on the page, such as `fbq`, `gtag`, `lintrk`, or another vendor function.
- Do not paste an entire base pixel again inside every conversion block unless the platform specifically tells you to do that.
- Follow your consent policy before firing advertising or analytics scripts.
- Test with the platform browser helper or diagnostics tool before sending paid traffic.

## Troubleshooting

**The event does not appear in the platform.**

- Confirm the platform base pixel or global script is installed on the same page.
- Confirm the UXON Lead event is actually being recorded.
- Check whether **Fire only on UXON AI landing pages** is blocking the event on an external page.

**The platform reports duplicate conversions.**

- Check whether the same conversion is also fired by Google Tag Manager, a form plugin, or code on the root website.
- Use the UXON AI landing page scope when the conversion should only fire from UXON-hosted pages.
