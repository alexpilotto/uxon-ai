# Troubleshoot Intelligence runs

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Fix common run issues, recover missing data, and understand download readiness states.
- Use this guide when a run does not complete as expected, review coverage is low, or report download is unavailable.
- Run and queue issues **Problem:** Run does not start.

## Source
- Help Center: [Troubleshoot Intelligence runs](https://docs.uxon.ai/en/articles/14754202-troubleshoot-intelligence-runs)
- Source collection: AI content tools

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Reports API](../../../skills/reports.md)
- [Weekly optimization runbook](../../../runbooks/weekly-optimization.md)

## Article
Use this guide when a run does not complete as expected, review coverage is low, or report download is unavailable.

## Run and queue issues

**Problem:** Run does not start.

- Check required inputs: brand domain, 3 competitors, market, and at least one review source.
- If CSV is selected, upload a valid CSV with at least one usable review row.

**Problem:** You see a message that a run is already queued.

- Only one active queued/running job is allowed per brand at a time. Wait for completion before queueing another run.

## Input validation issues

**Problem:** Competitor validation errors.

- Use exactly 3 competitor domains.
- Make sure competitors are unique.
- Do not use your current brand domain in competitor fields.

**Problem:** Market is rejected.

- Choose a country from the search list instead of free-text values.

## Review collection issues

**Problem:** No review rows extracted.

- Try another review source or add CSV input for better coverage.
- Review notices shown in the Review intelligence section for source-specific issues.

**Problem:** CSV issues.

- Max file size is 1MB.
- CSV must include **review_body**.
- Use the built-in CSV example to match expected format.

## Download report issues

**Problem:** Download not available yet.

- Report export is still preparing. Wait and try **Download report** again.

**Problem:** Download fails.

- Run Intelligence again to regenerate the downloadable report file.

**Problem:** Report marked failed.

- Retry with clean inputs and fewer variables, then expand sources in a second pass.
