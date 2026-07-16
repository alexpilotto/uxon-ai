# Use multiple goals in experiments

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Measure more than one conversion goal in an experiment and understand All conversions reporting.
- UXON AI experiments can measure one or more selected goals.
- This helps when more than one action is valuable, such as a form lead and a phone call.

## Source
- Help Center: [Use multiple goals in experiments](https://docs.uxon.ai/en/articles/15760749-use-multiple-goals-in-experiments)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)
- [Conversion tracking API](../../../skills/conversion-tracking.md)

## Article
UXON AI experiments can measure one or more selected goals. This helps when more than one action is valuable, such as a form lead and a phone call.

## When to use multiple goals

Use multiple goals when the experiment should optimize for a combined business outcome, not just one event.

Examples:

- Form lead + phone call
- Book demo + contact form
- Checkout started + purchase, if both are useful to monitor

## Select goals during setup

1. Open the experiment setup flow.
2. Go to **Goal tracking**.
3. Select one or more metrics.
4. Launch the experiment when setup is complete.

At least one goal is required.

## Bounce cannot be combined with another goal

**Bounce** must be used by itself. Do not combine Bounce with conversion goals such as Lead, Phone call, Purchase, or custom events.

Reason: Bounce measures lack of engagement, while conversion goals measure successful actions. Combining them would make the experiment result harder to trust.

## Goals lock after launch

Selected goals are locked once an experiment is running. This protects reporting integrity because changing goals mid-test would change what success means after data has already been collected.

## How reporting works

Experiment reports can show:

- **All conversions**: combined reporting across selected goals.
- **One selected goal**: reporting for a specific conversion event only.

When All conversions is selected, UXON avoids inflating winner logic by counting a visitor once for the combined selected goal outcome when needed.

## Best practice

Select goals that represent the same business objective. For lead generation, form submissions and phone calls usually belong together. For ecommerce, purchase and revenue events may be better separated from lighter engagement events.
