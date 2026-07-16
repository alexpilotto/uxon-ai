# Page build payments and billing

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Understand checkout triggers, payment states, and common payment issues.
- Page build requests can be paid in one of two ways: immediate paid submission (no checkout required) or Stripe checkout payment.
- Complete the request form in Page Builds.

## Source
- Help Center: [Page build payments and billing](https://docs.uxon.ai/en/articles/14753867-page-build-payments-and-billing)
- Source collection: Landing pages overview

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)

## Article
Page build requests can be paid in one of two ways: immediate paid submission (no checkout required) or Stripe checkout payment.

## When checkout appears

At the end of the request form, UXON shows one of these actions:

- **Proceed to Checkout** when payment is required
- **Submit Request** when the request can bypass checkout

If a request is still unpaid, open request details and select **Complete payment** to start checkout.

## Stripe checkout flow

1. Complete the request form in Page Builds.
2. Select **Proceed to Checkout**.
3. Pay in Stripe.
4. You are redirected back to **/dashboard/requests** with payment result.

After successful payment, the request is marked as paid and continues through delivery workflow.

## Payment statuses explained

| Payment status | Meaning |
| --- | --- |
| **Awaiting payment** | Checkout is required before the request can continue normally. |
| **Paid** | Payment is confirmed, or the request qualified for no-charge submission. |
| **Refunded** | The payment was refunded. |

## Troubleshooting

**Payment was canceled.**

- Open the request in Page Builds and select **Complete payment** again.

**I do not see checkout.**

- Your request may have been submitted under free trial pages or zero-price configuration.
- Check payment badge in request details to confirm whether it is already paid.

**Complete payment button is unavailable.**

- Only requests in **Awaiting payment** can start checkout.
