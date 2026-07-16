# View form submissions and response details in UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Review submitted responses, source context, device data, UTMs, and raw payload details.
- The submissions page shows the responses captured by a published form, plus useful source and device metadata.
- Select the submission count or open the action menu and choose **Submissions**.

## Source
- Help Center: [View form submissions and response details in UXON AI](https://docs.uxon.ai/en/articles/15391788-view-form-submissions-and-response-details-in-uxon-ai)
- Source collection: Forms and submissions / Submissions and automations

## Related UXON Guides
- [Contacts API](../../../../skills/contacts.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)

## Article
The submissions page shows the responses captured by a published form, plus useful source and device metadata.

## Open form submissions

1. Go to **Dashboard** > **Forms**.
2. Find the form.
3. Select the submission count or open the action menu and choose **Submissions**.

## What the submissions table shows

- **Submitted**: date and time of the response.
- **Response**: a short summary of submitted answer values.
- **Source**: campaign, source, page host, or direct/unknown.
- **Device**: desktop, mobile, tablet, or unknown.
- **Action**: open the submission details panel.

Submissions are paginated in groups of 50.

## Review submission details

Select a row or **View** to open the details panel. The panel includes:

- **Responses**: submitted field values.
- **Submission metadata**: submission ID, form version ID, landing page ID, variant ID, device, page URL, and referrer.
- **UTM values**: campaign parameters collected from the submission context.
- **Device details**: device metadata sent with the submission.
- **Stored payload**: the sanitized payload stored for the submission.

## Preview the form

Use **Preview form** at the top-right of the submissions page to open the public form in a new tab.

> Use source, UTM, landing page, and variant metadata to connect form responses back to campaign performance.

## Troubleshooting

**No submissions appear.**

- Submit the published form once, then refresh the submissions page.

**The source says Direct / unknown.**

- The submission did not include usable UTM or page source information.
