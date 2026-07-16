# Set up external-page experiments in UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Install the UXON pixel early and configure targets, URL Patterns, URL parameters, filters, and conversions for external-page experiments.
- Use this guide when an experiment includes an **External** target, a **URL Patterns** target, or any external page where conversions happen.
- External-page experiments can work well, but setup quality matters because UXON cannot control how fast your external website loads the pixel.

## Source
- Help Center: [Set up external-page experiments in UXON AI](https://docs.uxon.ai/en/articles/15440025-set-up-external-page-experiments-in-uxon-ai)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)
- [Conversion tracking API](../../../skills/conversion-tracking.md)

## Article
Use this guide when an experiment includes an **External** target, a **URL Patterns** target, or any external page where conversions happen. External-page experiments can work well, but setup quality matters because UXON cannot control how fast your external website loads the pixel.

## Choose the right target type

In experiment setup, each side uses a **Target page** type.

| Target type | Use it when | Pixel requirement |
| --- | --- | --- |
| **UXON AI** | The page or variant is hosted by UXON AI. | No manual install is needed. UXON AI landing pages include the pixel automatically. |
| **External** | The page is hosted on your own website or another domain. | Install the UXON pixel on every external page that can enter or receive experiment traffic. |
| **URL Patterns** | You want a group of URLs to enter the experiment based on matching rules. | The pixel must be present on every page that should match the pattern. |

## The simple rule

The UXON pixel must load on every external page that participates in the experiment:

- The external control URL
- The external variant URL
- Any page matched by URL Patterns
- Any external page where a conversion happens, such as a form thank-you page, checkout page, booking confirmation page, or custom conversion page

If the pixel is missing from one of those pages, UXON may not be able to assign the visitor, persist the correct variant, record the exposure, or attribute the conversion correctly.

## Install the pixel as early as possible

For external-page experiment delivery, install the UXON pixel in the page **head**, as high as practical, before heavy third-party scripts.

Recommended install:

1. Go to **Pixel & Events**.
2. Open **Tracking Pixel**.
3. Select **Copy Code**.
4. Paste the snippet into the `` of each external experiment page.
5. Add each external domain in **Domain Whitelisting**.
6. Use **Verify Installation** for each domain before launching traffic.

> Best practice: direct installation high in the page head gives the fastest experiment delivery. Google Tag Manager can work, but if the tag fires late, visitors may briefly see the original page before being redirected to their assigned variant.

## Using URL Patterns

URL Patterns let one side of the experiment match a group of incoming URLs instead of one fixed page. Use them for tests such as sending traffic from a set of campaign URLs to one UXON AI or external destination.

- Only one side can use URL Patterns.
- The other side must be a concrete destination: **UXON AI** or **External**.
- Use **Include URLs** to define what can enter the experiment.
- Use **Exclude URLs** to block specific URLs from entering.
- Patterns can match the path, query string, and hash fragment present when the page loads.

## Preserve URL parameters on redirects

**Preserve URL parameters on redirect** is enabled by default. It keeps useful tracking values from the visitor's landing URL when UXON redirects them to their assigned destination.

This helps PPC and analytics teams keep attribution intact for UTMs, click IDs, and similar parameters that downstream forms, CRMs, analytics tools, or ad platforms may read.

Example:

```text
Visitor lands on /landing-page?utm_source=google&utm_campaign=spring&gclid=abcVisitor is assigned /new-pageRedirect becomes /new-page?utm_source=google&utm_campaign=spring&gclid=abc
```

Turn this off only when the destination must not receive the original query parameters.

## Goal tracking

Experiments can measure one or more selected goals. Select the conversion actions that define success before launch. Goals are locked once the experiment is running so reporting stays consistent.

If you select more than one goal, experiment reports can show **All conversions** or one selected conversion at a time.

## How external-page delivery works

When the UXON pixel loads on an eligible experiment page, it checks whether the visitor already has an assignment for that experiment.

- If the visitor already has an assignment, UXON keeps that assignment.
- If the visitor is new and enters from an eligible target, UXON assigns the visitor based on the traffic split.
- If the visitor is on the wrong URL for their assignment, UXON redirects them to the assigned page.

Because external pages are not hosted by UXON, this decision happens after the pixel loads in the browser. UXON cannot fully remove redirect delay or visual flicker on external websites unless your own site, CDN, or routing layer participates in server-side routing.

## Before-launch checklist

- The experiment status is ready to run.
- Control and Variant targets are correct.
- External URLs match the live URLs visitors will land on.
- URL Pattern conditions are specific enough to avoid unwanted traffic.
- The UXON pixel is installed on every external page that can enter or receive experiment traffic.
- The UXON pixel is installed on external conversion pages.
- Every external domain is added in **Domain Whitelisting**.
- Traffic filters, Geo filters, device targeting, and visitor targeting match the campaign you plan to launch.
- Selected goal events are configured and can be tested.

## How to test before sending paid traffic

1. Open the eligible entry URL in a clean browser session.
2. Confirm the UXON pixel request loads in the browser network tab.
3. Refresh or revisit the page and confirm the visitor keeps the same assigned variant.
4. Complete each selected conversion action and confirm the event appears in UXON.
5. Repeat on mobile if the campaign has meaningful mobile traffic.

## Expected behavior

- Existing visitors keep their assigned variant.
- New visitors entering from an eligible target are assigned according to the traffic split over time.
- Small samples may not match the split exactly. The ratio should get closer as traffic volume grows.
- If you change the traffic split, existing visitors keep their previous assignment. New visitors follow the new split.
- Root domains and subdomains can share visitor and assignment cookies when browser rules allow it. Different root domains cannot automatically share first-party browser storage.

## Troubleshooting

**Visitors are not being redirected to the assigned page.**

- Confirm the UXON pixel is installed on the page they landed on.
- Confirm the domain is in **Domain Whitelisting**.
- Check that the experiment is running and the target URL or URL Pattern matches the live page URL.
- Check whether traffic filters, Geo filters, visitor targeting, or device targeting exclude the visitor.

**Visitors briefly see the wrong page before redirect.**

- Move the UXON pixel higher in the page ``.
- Avoid delaying the pixel behind non-critical tag manager triggers.
- Reduce slow third-party scripts before the pixel.
- For external pages, some redirect delay is normal because UXON does not control the external server render path.

**Conversions are missing or unattributed.**

- Confirm the UXON pixel is present where the conversion happens.
- Confirm the conversion event fires at the correct moment.
- Confirm the conversion domain is whitelisted.
- Check that the conversion happened within your attribution window.
