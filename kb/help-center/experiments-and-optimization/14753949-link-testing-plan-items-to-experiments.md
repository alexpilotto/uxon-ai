# Link testing plan items to experiments

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Connect tests to experiments so statuses and outcomes stay aligned.
- Linking Testing Plan items to experiments keeps planning and execution aligned, with clearer status tracking and results visibility.
- In the **Linked experiments** section, search for the experiment.

## Source
- Help Center: [Link testing plan items to experiments](https://docs.uxon.ai/en/articles/14753949-link-testing-plan-items-to-experiments)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)

## Article
Linking Testing Plan items to experiments keeps planning and execution aligned, with clearer status tracking and results visibility.

## Link an existing experiment

1. Open a test in **Testing Plan**.
2. In the **Linked experiments** section, search for the experiment.
3. Select the experiment to link it.

After linking, related status and outcome fields are surfaced in your testing workflow.

## Create a draft A/B test directly from Testing Plan

1. Open or create a test item.
2. Enable **Create new draft A/B test**.
3. Save the test. UXON creates and links a draft experiment automatically.

## Refresh linked metrics

Select **Refresh** in Testing Plan to update linked experiment metrics and outcomes.

- Linked active tests are refreshed.
- Ended experiments are skipped.
- Any missing experiment links are reported.

## What updates after linking

- Linked experiment reference in the table
- Status alignment support (for running, paused, ended flows)
- Statistical significance and result visibility (when enabled in settings)

## Troubleshooting

**No experiments found.**

- Check you are in the correct client account and that experiments exist there.

**Significance or result is blank.**

- Refresh linked metrics and confirm the experiment has enough data.
