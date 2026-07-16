# How traffic split and redirects work

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Understand experiment assignment, traffic split, redirects, and visitor consistency in UXON AI.
- Traffic split controls how new eligible visitors are assigned between Control and Variant.
- For example, a 30/70 split means about 30% of new eligible visitors are assigned to Control and about 70% are assigned to Variant over time.

## Source
- Help Center: [How traffic split and redirects work](https://docs.uxon.ai/en/articles/15760750-how-traffic-split-and-redirects-work)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)

## Article
Traffic split controls how new eligible visitors are assigned between Control and Variant.

For example, a 30/70 split means about 30% of new eligible visitors are assigned to Control and about 70% are assigned to Variant over time.

## Basic flow

1. Visitor lands on an eligible experiment target.
2. The UXON pixel checks whether the visitor qualifies for the experiment.
3. UXON checks whether the visitor already has an assignment.
4. If they already have an assignment, UXON keeps it.
5. If they are new and entered through an eligible target, UXON applies the traffic split.
6. If their assigned destination is different from the page they are on, UXON redirects them.

## Existing visitors keep their assignment

Once a visitor is assigned to Control or Variant, UXON keeps that assignment for the attribution window. This prevents visitors from seeing a different experience on every visit.

## Redirect examples

**50/50 A/B test:**

- Half of new eligible visitors stay on Control.
- Half of new eligible visitors redirect to Variant.

**0/100 redirect-style test:**

- New eligible visitors are assigned to Variant.
- Visitors landing on the Control target are redirected to Variant.

**100/0 holdout:**

- New eligible visitors stay on Control.
- This can be useful when preparing or validating setup.

## Direct visits to a destination page

If a visitor directly lands on a destination page without entering through the experiment entry path and without an existing assignment, UXON avoids forcing that visitor into the test just because the destination URL is open.

This protects test integrity because the visitor was not randomized through the normal experiment entry path.

## External page redirect speed

For UXON AI hosted pages, UXON can optimize delivery because the page is under UXON control.

For external pages, the redirect decision happens after the UXON pixel loads in the visitor's browser. Install the pixel high in the page `` to reduce delay and visual flicker.

## What can affect whether a visitor enters

- Target page type: UXON AI, External, or URL Patterns
- Visitor targeting: all, new, or returning visitors
- Device targeting
- Traffic filters
- Geo filters
- Experiment status

## Test trigger entry conditions

Test trigger controls when an eligible visitor enters the experiment after the target page and filters match.

- **User lands (entry page)**: use this when the visitor must arrive on the target page as their entry page. This is best for paid traffic, email campaigns, and landing-page tests where first-page experience matters.
- **User visits (from anywhere)**: use this when the visitor can enter the experiment whenever they reach the target page, including from internal navigation, return visits, or external links.

For cleaner campaign tests, use **User lands** with Traffic filters such as source, medium, campaign, or content. Use **User visits** when the page is part of a wider site journey and internal visitors should also enter the test.
