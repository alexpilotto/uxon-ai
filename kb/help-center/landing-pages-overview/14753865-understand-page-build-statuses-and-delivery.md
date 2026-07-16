# Understand page build statuses and delivery

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Track build progress from submission to delivery.
- Every page build request moves through clear statuses so you can see progress and know when action is required.
- | | **In progress** | UXON has started production work.

## Source
- Help Center: [Understand page build statuses and delivery](https://docs.uxon.ai/en/articles/14753865-understand-page-build-statuses-and-delivery)
- Source collection: Landing pages overview

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Conversion tracking API](../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../examples/curl/setup-tracking.sh)

## Article
Every page build request moves through clear statuses so you can see progress and know when action is required.

## Build and payment statuses

Each request shows two status badges:

- **Build status**: submitted, in progress, delivered, or canceled
- **Payment status**: awaiting payment, paid, or refunded

| Build status | Meaning |
| --- | --- |
| **Submitted** | Request was created and is waiting for the next action. |
| **In progress** | UXON has started production work. |
| **Delivered** | Build is marked as delivered. |
| **Canceled** | Request was canceled and is no longer active. |

## Allowed status transitions

Build statuses follow a strict progression:

- **Submitted** can move to **In progress** or **Canceled**
- **In progress** can move to **Delivered** or **Canceled**
- **Delivered** and **Canceled** are final states

## Where to view request details

Open any row in **Page Builds** to see full request details, including:

- Client details, brief inputs, and asset links
- Target delivery date
- Preview URL (when provided)
- Delivery notes (when provided)

## Status emails and delivery communication

UXON sends email updates for key status moments:

- When your request is received
- When status changes to **In progress**
- When status changes to **Delivered**

Status emails can include target delivery date, preview URL, and delivery notes when available.

> If payment is still **Awaiting payment**, production may not start yet. Complete payment from request details to continue.

## Troubleshooting

**I do not see status actions in request details.**

- Final states (**Delivered** or **Canceled**) have no further status actions.

**I need another status email.**

- Status emails are available for in-progress and delivered updates.
