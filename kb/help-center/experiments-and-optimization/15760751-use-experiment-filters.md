# Use experiment filters

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Control which visitors enter an experiment using visitor, device, traffic, and Geo filters.
- Experiment filters control who can enter an experiment.
- Use them when a test should apply only to a specific audience, campaign, device type, or country group.

## Source
- Help Center: [Use experiment filters](https://docs.uxon.ai/en/articles/15760751-use-experiment-filters)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)

## Article
Experiment filters control who can enter an experiment. Use them when a test should apply only to a specific audience, campaign, device type, or country group.

## Filter types

| Filter | Use it for |
| --- | --- |
| **Visitor targeting** | All visitors, new visitors, or returning visitors. |
| **Device targeting** | All devices, desktop only, or mobile only. |
| **Traffic filters** | UTM source, medium, campaign, or content values. |
| **Geo filters** | Include or exclude visitors by country or region group. |

## Visitor targeting

Use visitor targeting to decide whether the experiment should include everyone, only first-time visitors, or only returning visitors.

For most acquisition campaigns, **All visitors** is the safest default unless your hypothesis is specifically about new or returning visitor behavior.

## Device targeting

Use device targeting when the experience or hypothesis is device-specific. For example, a mobile form layout test may only need mobile visitors.

## Traffic filters

Use traffic filters when the experiment should only apply to campaign traffic with specific UTM values.

Available traffic filters include:

- `utm_source`
- `utm_medium`
- `utm_campaign`
- `utm_content`

Traffic filters are best for separating campaign audiences, such as paid search traffic from paid social traffic.

## Geo filters

Use Geo filters to include or exclude visitors by country. You can select individual countries or region groups.

**Any country** means no Geo filter is applied.

**Include unknown traffic** controls whether visitors with no resolved country can enter the experiment.

## Performance

Experiment filters are included in the pixel's experiment data. The pixel does not need an extra page-load request just to evaluate visitor, device, traffic, or Geo filters.

## Best practices

- Keep filters as simple as possible.
- Use filters only when they match the test hypothesis.
- Avoid narrowing traffic so much that the test cannot collect useful data.
- Check filters before launch because they change who enters the test.
