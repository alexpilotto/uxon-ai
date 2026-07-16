# Use URL Patterns in experiments

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Target groups of URLs in UXON AI experiments using include and exclude conditions.
- Use **URL Patterns** when you want a group of URLs to enter an experiment instead of selecting one exact page.
- This is useful for campaign URLs, location pages, product/category pages, or external pages that share a path or query parameter.

## Source
- Help Center: [Use URL Patterns in experiments](https://docs.uxon.ai/en/articles/15760748-use-url-patterns-in-experiments)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)

## Article
Use **URL Patterns** when you want a group of URLs to enter an experiment instead of selecting one exact page.

This is useful for campaign URLs, location pages, product/category pages, or external pages that share a path or query parameter.

## When to use URL Patterns

- You want all URLs containing a campaign query string to enter a test.
- You want all URLs under one path to redirect to a specific destination.
- You want a UXON AI landing page variant to be targeted by its live URL instead of selecting it directly.
- You want to exclude internal, preview, or low-quality URLs from the test.

## How URL Patterns work

In the **Setup** section, choose **URL Patterns** on either Control or Variant. Only one side can use URL Patterns. The other side must be a concrete destination: **UXON AI** or **External**.

When a visitor lands on a page, the UXON pixel checks the current URL against your pattern conditions. If the URL matches and the visitor passes the experiment filters, traffic split decides whether the visitor stays on the matched URL or redirects to the other side.

## Conditions

Each URL Pattern can use up to five total conditions.

| Condition type | What it does |
| --- | --- |
| **Include URLs** | Defines URLs that can enter the experiment. |
| **Exclude URLs** | Blocks matching URLs from entering, even if they match an include condition. |

At least one Include URLs condition is required.

## Operators

- **is**: the URL must match the value exactly.
- **contains**: the URL must include the value somewhere.
- **starts with**: the URL must start with the value.
- **ends with**: the URL must end with the value.

URL matching checks the URL present on page load, including path, query string, and hash fragment. It does not re-run just because a visitor clicks an in-page anchor after the page has already loaded.

## Examples

**Target a campaign query parameter:**

```text
Include URLs contains campaign=spring
```

**Target a site section but exclude admin pages:**

```text
Include URLs contains /pricingExclude URLs contains /internal
```

**Target a hash-based page state:**

```text
Include URLs contains /quote#enterprise
```

## Performance

URL Pattern rules are included in the experiment pixel payload. The pixel does not need an extra page-load request just to evaluate URL Patterns.

For external pages, install the UXON pixel high in the page `` so the match and redirect decision can happen as early as possible.

## Before you launch

- Keep pattern values specific enough to avoid unrelated traffic.
- Use Exclude URLs for preview, admin, internal, or unsupported paths.
- Confirm the pixel is installed on every external URL that should match.
- Test in a clean browser session before sending paid traffic.
