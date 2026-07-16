# Use the UXON AI GTM template for GA4 experiment data

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Use this template when your GA4 is installed via Google Tag Manager and you want clean segmentation by UXON landing-page variant and experiment arm.
- What this setup sends on landing-page load: Landing page ID Landing page variant Experiment ID (if active) Control vs variant arm (if active) Setup: 1.
- In UXON, go to Dashboard > Settings > Tracking & Analytics.

## Source
- Help Center: [Use the UXON AI GTM template for GA4 experiment data](https://docs.uxon.ai/en/articles/14605510-use-the-uxon-ai-gtm-template-for-ga4-experiment-data)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)
- [Conversion tracking API](../../../skills/conversion-tracking.md)

## Article
Use this template when your GA4 is installed via Google Tag Manager and you want clean segmentation by UXON landing-page variant and experiment arm.

What this setup sends on landing-page load:

- Landing page ID
- Landing page variant
- Experiment ID (if active)
- Control vs variant arm (if active)

Setup:

1. In UXON, go to Dashboard > Settings > Tracking & Analytics.
2. Click Download DTM Template.
3. Import it into your GTM container.
4. Publish the container.

Verify:

1. Open GTM Preview and visit a UXON landing page.
2. Confirm the UXON context signal appears.
3. Check GA4 DebugView and confirm the same context is received.

Result:
You can segment GA4 traffic by UXON variant/experiment context without relying on visible URL parameters.
