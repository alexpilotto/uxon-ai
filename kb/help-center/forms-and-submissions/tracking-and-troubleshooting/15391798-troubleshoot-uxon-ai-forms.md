# Troubleshoot UXON AI forms

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Fix common form publishing, embedding, submission, notification, customer confirmation, webhook, and tracking issues.
- Use this guide when a UXON AI form is unavailable, missing from a landing page selector, failing validation, or not sending expected follow-up data.
- The form says unavailable Confirm the form exists in **Dashboard** > **Forms**.

## Source
- Help Center: [Troubleshoot UXON AI forms](https://docs.uxon.ai/en/articles/15391798-troubleshoot-uxon-ai-forms)
- Source collection: Forms and submissions / Tracking and troubleshooting

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)
- [Contacts API](../../../../skills/contacts.md)

## Article
Use this guide when a UXON AI form is unavailable, missing from a landing page selector, failing validation, or not sending expected follow-up data.

## The form says unavailable

- Confirm the form exists in **Dashboard** > **Forms**.
- Confirm the form status is **Published**.
- If the form is archived, publish or use a different active form.

## The landing page form picker is empty

- Publish at least one form first. Draft forms do not appear in the landing page form picker.
- Check that you are editing the correct workspace and client account.

## Submissions fail with a form version message

If a landing page uses an older embedded form version and the form was republished later, submissions can fail because the embedded version is no longer the current published version.

1. Open the form and confirm the latest changes are saved or published.
2. Open the landing page that uses the form.
3. Reopen the form picker, confirm the selected form, then save or publish the landing page again.
4. Submit a fresh test response.

## A visitor cannot submit the form

- Check required fields.
- Review validation rules for email, URL, number, date, pattern, selections, and file type.
- Check conditional fields that become visible after earlier answers.

## Notifications or contacts are missing

- For internal notification emails, check the recipient list, spam folder, and whether the notification is active.
- For customer confirmation emails, confirm the form has an Email field and the confirmation is using the correct customer email field.
- Confirm the customer confirmation has a valid reply-to email. Reply-to is required so replies do not go to a no-reply sender address.
- If the email is conditional, confirm the submitted answers match the condition.
- Confirm the form was saved or published after changing notification settings.
- For contacts, confirm **Save submissions to contacts** is enabled and the submission includes an email or phone number.

## The customer confirmation sender or reply address looks wrong

- Customer confirmations use your configured **From name** with UXON AI's verified form sender address.
- Replies go to the **Reply-to email** in the confirmation settings.
- To change where replies go, edit the confirmation and update the reply-to email, then save or publish the form.

## Webhook or tracking data is missing

- Confirm the webhook URL is complete and the receiving endpoint accepts JSON POST requests.
- Confirm data layer events or conversion events are enabled in **Form settings** > **Tracking**.
- For UTMs, confirm the visitor URL includes UTM parameters.

## Address autocomplete is not working

- Open **Form settings** > **Integrations**.
- Confirm the address autocomplete provider is set correctly.
- For Google Places or Mapbox, confirm the browser API key or public token is valid and allowed on the form domain.
- If autocomplete cannot load, the address field remains usable as a normal text field.

After any form or landing page change, run one real test submission before sending traffic to the page.
