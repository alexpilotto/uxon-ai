# Send form notification emails and save submissions to contacts

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Configure internal alerts, customer confirmation emails, and contact saving for UXON AI form submissions.
- Form submission settings control who gets notified, whether submitters receive a confirmation email, and whether UXON AI creates or updates contacts from submitted lead details.
- Send internal notification emails Use internal notification emails when your team, client, or sales inbox should receive a copy of a submission.

## Source
- Help Center: [Send form notification emails and save submissions to contacts](https://docs.uxon.ai/en/articles/15391795-send-form-notification-emails-and-save-submissions-to-contacts)
- Source collection: Forms and submissions / Submissions and automations

## Related UXON Guides
- [Contacts API](../../../../skills/contacts.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)

## Article
Form submission settings control who gets notified, whether submitters receive a confirmation email, and whether UXON AI creates or updates contacts from submitted lead details.

## Open submission settings

1. Go to **Dashboard** > **Forms**.
2. Open the form in **Form Builder**.
3. Select **Form settings**.
4. Go to **Submissions**.

## Send internal notification emails

Use internal notification emails when your team, client, or sales inbox should receive a copy of a submission.

1. In **Email notifications**, select **Add notification**.
2. Enter a notification name.
3. Add one or more recipient email addresses. Separate multiple addresses with commas, semicolons, or new lines.
4. Optional: enable **Send conditionally** to send the email only when a submitted answer matches your rule.
5. Customize the email subject and initial message.
6. Save the notification, then save or publish the form.

Internal notification emails include response values and metadata such as form, site, score, page URL, and referrer when available.

## Send customer confirmation emails

Use customer confirmation emails when the person who submitted the form should receive a plain-text follow-up message.

1. Add an **Email** field to the form. UXON AI uses this field to know where to send the confirmation.
2. In **Customer confirmation emails**, select **Add confirmation**.
3. Choose the customer email field. If the form has more than one email field, select the exact field that should receive the confirmation.
4. Enter the **From name**. This can be your brand, client, or team name.
5. Enter a valid **Reply-to email**. This is required because confirmations are sent from a shared no-reply sender address, and replies should go to a real inbox.
6. Optional: add **CC** or **BCC** recipients for internal copies or archives.
7. Optional: enable **Send conditionally** to send this confirmation only for matching submissions.
8. Customize the subject and plain-text body, then save or publish the form.

Customer confirmations are sent as plain text, not as a designed or graphic email. The visible sender name can match your brand, while the sender address uses UXON AI's verified form sender. Replies go to the reply-to email you set.

Available personalization tokens appear beside the body field based on the fields in your form. Use tokens such as `#{{first_name}}`, `#{{last_name}}`, `#{{email}}`, and `#{{phone}}` when those details are available.

## Save submissions to contacts

**Save submissions to contacts** is enabled by default. When enabled, UXON AI can create or update a contact if the submission includes an email address or phone number.

Existing contacts are matched by email first, then phone. New contacts can include name, email, phone, referrer, UTM values, landing page, variant, and device type.

If a submission has no email and no phone number, no contact is created.

Best practice: include an Email or Phone field when you want form submissions to become contacts automatically.

## Test your setup

1. Publish the form.
2. Submit a real test response with an email or phone value.
3. Open the form submissions page to confirm the response.
4. Check Contacts if contact saving is enabled.
5. If customer confirmations are enabled, check the test customer inbox and confirm replies go to the reply-to address.

## Troubleshooting

**No internal notification email arrived.**

- Check the recipient list, spam folder, and whether the form was successfully submitted.
- Confirm the notification is active and the form was saved or published after changing settings.
- If the notification is conditional, confirm the test submission matches the condition.

**No customer confirmation email arrived.**

- Confirm the form includes an Email field and the confirmation is using the correct customer email field.
- Confirm the reply-to email is valid and the confirmation is active.
- Check whether conditional sending is enabled and whether the test submission matches the condition.
- Check the customer inbox spam or promotions folder.

**A customer replied but the reply went to the wrong inbox.**

- Open the customer confirmation and update the **Reply-to email**. Replies do not go to the shared no-reply sender address.

**A contact was not created.**

- Confirm **Save submissions to contacts** is enabled and the submission includes an email or phone number.
