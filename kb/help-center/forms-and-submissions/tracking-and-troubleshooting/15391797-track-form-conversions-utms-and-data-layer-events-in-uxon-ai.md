# Track form conversions, UTMs, and data layer events in UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Map form submissions to conversion events and pass form context into tracking.
- UXON AI forms can send submission context into your tracking setup so form completions connect back to campaigns, landing pages, and variants.
- Enable data layer events **Enable data layer events** sends form interaction context to the page data layer when visitors move through the form.

## Source
- Help Center: [Track form conversions, UTMs, and data layer events in UXON AI](https://docs.uxon.ai/en/articles/15391797-track-form-conversions-utms-and-data-layer-events-in-uxon-ai)
- Source collection: Forms and submissions / Tracking and troubleshooting

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)
- [Contacts API](../../../../skills/contacts.md)

## Article
UXON AI forms can send submission context into your tracking setup so form completions connect back to campaigns, landing pages, and variants.

## Open tracking settings

1. Open the form in Form Builder.
2. Select **Form settings**.
3. Go to **Tracking**.

## Enable data layer events

**Enable data layer events** sends form interaction context to the page data layer when visitors move through the form.

Screen events can include form ID, form title, form version ID, screen ID, screen title, answered question IDs, answer context, score, landing page ID, variant ID, UTMs, page URL, referrer, device type, and validation state.

## Successful submission event

After a successful submission, UXON AI pushes a `uxon_form_submit` event when data layer events are enabled. This event uses the same shared payload sent to configured webhooks.

```text
{ "event": "uxon_form_submit", "context": "uxon_form", "form_id": "form_123", "form_title": "Proposal Request", "form_version_id": "version_123", "submission_id": "submission_123", "answered_question_ids": ["q_branch"], "answers": { "question_q_branch": "Strata management branch", "answer_q_branch": { "answer_id": "option_nsw", "answer_label": "NSW branch", "answer_value": "nsw-branch", "answers": [] } }, "attribution": { "source": "Google", "medium": "CPC", "source_medium_label": "Google / CPC", "channel_key": "paid-search", "channel_label": "Paid Search" }, "page_url": "https://example.com/quote?utm_source=google&utm_medium=cpc&utm_campaign=proposal_request", "referrer": "https://www.google.com/", "utm": { "utm_source": "google", "utm_medium": "cpc", "utm_campaign": "proposal_request" }, "device_type": "desktop"}
```

## Answer format

Answer data uses `question_` for the question label and `answer_` for the submitted answer object. Choice fields include option IDs, labels, and values. Multi-choice fields include selected values plus an `answers` array with one object per selected option.

## Fire a conversion event on submission

1. Turn on **Fire conversion event on submission**.
2. Choose the **Conversion event**. The default is **Lead**.
3. Save or publish the form.

After a successful submission, UXON AI can also push the selected conversion event to the data layer and to UXON tracking when available.

## Google Ads conversion behavior

If the selected event is the active system **Lead** event and Google Ads conversion settings are configured for that event, UXON AI can also trigger the matching Google Ads conversion through gtag.

## UTM and attribution metadata

Form submissions capture UTM values from the form page URL and submission metadata. UXON AI also derives attribution fields such as `source`, `medium`, `source_medium_label`, `channel_key`, and `channel_label` from UTM values, click IDs, referrer, and page URL context. If no campaign source is present, the attribution logic still classifies the visit, for example as direct or referral where possible.

> Best practice: keep the form conversion event aligned with your reporting goal, such as Lead, Subscribe, Quote Request, or Demo Request.

## Troubleshooting

**The submission event does not appear.**

- Confirm the form submission completed successfully and **Enable data layer events** is on.

**The conversion event does not appear.**

- Confirm the form submission completed successfully and **Fire conversion event on submission** is enabled.

**UTM values are missing.**

- Confirm the visitor URL includes UTM parameters, such as utm_source and utm_campaign. If no UTM values are present, attribution can still use referrer and direct/referral logic.
