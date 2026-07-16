# Map conversion actions to events

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Map captured actions to the right conversion events and keep your reporting consistent.
- Strong event naming keeps reporting readable and makes optimization decisions faster.
- Use one naming system across all your auto-capture sources.

## Source
- Help Center: [Map conversion actions to events](https://docs.uxon.ai/en/articles/14754181-map-conversion-actions-to-events)
- Source collection: Customer events and tracking / Core tracking setup and controls

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Strong event naming keeps reporting readable and makes optimization decisions faster. Use one naming system across all your auto-capture sources.

## Open configuration for a source

1. Go to **Dashboard** -> **Event Tracking**.
2. In **Event Auto-Capture**, choose a source and select **Configure events**.
3. In **Report captured action as**, pick an existing event or type a new one.
4. Select **Enable** (first setup) or **Save changes** (existing setup).

## Event mapping best practice

Use outcome-based names so different tools roll up into clear performance signals.

| Captured action | Recommended event name |
| --- | --- |
| Form submitted | **Lead** |
| Meeting booked | **Book Demo** or **Lead** |
| Checkout completed | **Purchase** |
| Phone link clicked | **Phone Click** |

## How to keep data clean

- Map similar intent actions to the same event name when you want one KPI view.
- Avoid creating multiple names for the same business outcome.
- Review naming quarterly as your funnel evolves.

> A smaller set of consistent event names usually gives better decision quality than many near-duplicate event labels.

## Edit or disable a source later

Open the same source and select **Edit configuration**.

- Use **Save changes** to keep it enabled with updated mapping.
- Use **Disable** to stop auto-capture for that source.

## Troubleshooting

**I cannot save configuration.**

- Make sure **Report captured action as** is filled in. This field is required.

**My reports look fragmented.**

- Consolidate similar names (for example "Lead Form" and "Lead Submit") into one event label.
