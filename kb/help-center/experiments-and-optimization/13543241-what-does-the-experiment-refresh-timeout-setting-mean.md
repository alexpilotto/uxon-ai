# What does the experiment refresh timeout setting mean?

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Understand what the Experiment refresh timeout controls and why it does not delay redirects.
- **Experiment refresh timeout** controls how long the UXON pixel will try to refresh experiment rules in the background before giving up.
- It does **not** mean UXON waits before redirecting a visitor.

## Source
- Help Center: [What does the experiment refresh timeout setting mean?](https://docs.uxon.ai/en/articles/13543241-what-does-the-experiment-refresh-timeout-setting-mean)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)

## Article
**Experiment refresh timeout** controls how long the UXON pixel will try to refresh experiment rules in the background before giving up.

It does **not** mean UXON waits before redirecting a visitor. It is not a redirect timer.

## What experiment rules means

Experiment rules are the instructions the pixel uses to understand:

- which experiments are active
- which URLs or URL Patterns are part of each experiment
- traffic split
- visitor, device, traffic, and Geo filters
- redirect destinations

## What happens on page load

1. The visitor lands on the page.
2. The site-specific UXON pixel loads with the experiment data it needs.
3. UXON checks whether the visitor qualifies for an experiment.
4. UXON uses the visitor's existing assignment, or assigns a new visitor by traffic split.
5. If the visitor should be on another page, UXON redirects them.
6. Separately, the tracking core may refresh experiment rules in the background.

The timeout applies to step 6, not to the redirect decision.

## Available values

| Value | Meaning |
| --- | --- |
| **500ms** | Fastest cutoff. Gives the background refresh less time to complete. |
| **1,000ms** | Recommended balance for most teams. |
| **1,500ms** | Gives the background refresh more time on slower connections. |

## What it impacts

- **Background refreshes:** how long the pixel waits when checking UXON for fresher experiment rules.
- **Data freshness:** a longer timeout gives refresh requests more time to succeed.
- **Performance protection:** a shorter timeout stops slow background requests sooner.

## What it does not do

- It does not delay page rendering.
- It does not intentionally wait before redirecting a visitor.
- It does not change traffic split or goal tracking.

## Recommended setting

Keep this set to **1,000ms** unless UXON support recommends changing it. This is the best default for performance marketers because it protects speed while still giving normal background refreshes enough time to complete.
