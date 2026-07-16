# Send UXON AI form submissions to a webhook

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Post form submissions to another tool using a webhook URL.
- Use a webhook when another system needs to receive form submission data from UXON AI.
- Use a complete http:// or https:// URL.

## Source
- Help Center: [Send UXON AI form submissions to a webhook](https://docs.uxon.ai/en/articles/15391796-send-uxon-ai-form-submissions-to-a-webhook)
- Source collection: Forms and submissions / Submissions and automations

## Related UXON Guides
- [Contacts API](../../../../skills/contacts.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)

## Article
Use a webhook when another system needs to receive form submission data from UXON AI.

## Set up a form webhook

1. Open the form in Form Builder.
2. Select **Form settings**.
3. Go to **Submissions**.
4. Turn on **Enable webhook**.
5. Enter the full **Webhook URL**.
6. Save or publish the form.

Use a complete http:// or https:// URL. If no webhook URL is entered, no webhook is sent.

## What the webhook receives

On successful submission, UXON AI sends the same `uxon_form_submit` payload used by the form data layer event. This keeps webhook automations and analytics working from one shared submission contract.

The payload includes form, submission, contact, landing page, variant, answer, score, conversion, attribution, page, referrer, UTM, device, and uploaded file details when available.

```text
{ "event": "uxon_form_submit", "context": "uxon_form", "form_id": "form_123", "form_title": "Proposal Request", "form_version_id": "version_123", "submission_id": "submission_123", "contact_id": "contact_123", "answered_question_ids": ["q_branch"], "answers": { "question_q_branch": "Strata management branch", "answer_q_branch": { "answer_id": "option_nsw", "answer_label": "NSW branch", "answer_value": "nsw-branch", "answers": [] } }, "attribution": { "source": "Google", "medium": "CPC", "source_medium_label": "Google / CPC", "channel_key": "paid-search", "channel_label": "Paid Search" }, "page_url": "https://example.com/quote?utm_source=google&utm_medium=cpc&utm_campaign=proposal_request", "referrer": "https://www.google.com/", "utm": { "utm_source": "google", "utm_medium": "cpc", "utm_campaign": "proposal_request" }, "device_type": "desktop"}
```

## Answer format

Every trackable field uses a pair of answer keys:

- `question_`: the question label shown in the form.
- `answer_`: the submitted answer object.

For free-text, email, phone, address, and similar fields, `answer_value` contains the submitted value and `answer_id` / `answer_label` stay empty.

For single-choice fields, `answer_id`, `answer_label`, and `answer_value` identify the selected option. For multi-choice fields, `answer_value` contains the selected values and `answers` contains one object per selected option.

## Attribution data

Submission payloads include attribution fields automatically. UXON AI uses UTM values, click IDs, referrer, and page URL context to derive fields such as `source`, `medium`, `source_medium_label`, `channel_key`, and `channel_label`. If no campaign source is present, the attribution logic still classifies the visit, for example as direct or referral where possible.

## Delivery behavior

Webhook delivery happens after the submission is accepted and stored. If the webhook request fails, UXON AI logs the failure but does not block the visitor submission.

> Use a webhook endpoint that can accept JSON POST requests and respond quickly with a success status.

## Troubleshooting

**The webhook is not firing.**

- Confirm **Enable webhook** is on, the URL is complete, and the form was published after changes.

**The receiving app rejects the request.**

- Check that the endpoint supports JSON POST requests and does not require unsupported authentication headers.
- Confirm the receiving app accepts nested JSON objects for `answers` and `attribution`.
