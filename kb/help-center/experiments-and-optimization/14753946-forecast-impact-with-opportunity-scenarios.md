# Forecast impact with Opportunity scenarios

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Model landing page impact with low, likely, and high-case scenarios.
- Use the **Landing Page Impact Forecast** section in Opportunities to estimate performance impact before execution.
- Select the conversion events you want to model.

## Source
- Help Center: [Forecast impact with Opportunity scenarios](https://docs.uxon.ai/en/articles/14753946-forecast-impact-with-opportunity-scenarios)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)

## Article
Use the **Landing Page Impact Forecast** section in Opportunities to estimate performance impact before execution.

## Build a forecast in five steps

1. Select the conversion events you want to model.
2. Set **Forecast Period** (for example 30, 60, 90, or 180 days).
3. Set **Ad Spend Scaling** (keep spend, preset increase, or custom).
4. Set **Spend Increase Frequency** (monthly, weekly, every 3 days, or custom).
5. Choose **Diminishing Returns** on or off, then compare **Low Case**, **Likely Case**, and **High Case**.

## How to read forecast cards

- **Forecasted conversions**: projected total conversions.
- **Forecasted CVR**: projected conversion rate.
- **Cost/conversion**: projected efficiency.
- **Forecasted value**: projected conversion value.

## How to compare scenario rows

Each scenario row shows period, spend, CVR uplift, diminishing returns setting, forecast conversions, incremental conversions, and projected value. Select a row to make it the active planning view.

## Practical planning workflow

1. Start with **Likely Case** for your working plan.
2. Use **Low Case** for downside planning and risk management.
3. Use **High Case** to evaluate upside if execution quality is strong.

> Forecasts are directional planning estimates. Use them to prioritize and sequence landing page tests, not as a guaranteed outcome.
