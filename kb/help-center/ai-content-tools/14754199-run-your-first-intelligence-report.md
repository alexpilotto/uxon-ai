# Run your first Intelligence report

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Launch your first Intelligence run to map customer demand, competitor messaging, and review signals.
- Intelligence helps you quickly turn market signals into stronger landing page strategy.
- Your first run gives you customer segment insights, competitor positioning context, and review-based messaging opportunities.

## Source
- Help Center: [Run your first Intelligence report](https://docs.uxon.ai/en/articles/14754199-run-your-first-intelligence-report)
- Source collection: AI content tools

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Reports API](../../../skills/reports.md)
- [Weekly optimization runbook](../../../runbooks/weekly-optimization.md)

## Article
Intelligence helps you quickly turn market signals into stronger landing page strategy. Your first run gives you customer segment insights, competitor positioning context, and review-based messaging opportunities.

## Before you start

- Open the correct workspace and client account.
- Have your current brand website URL ready.
- Choose 3 competitor domains in the same market.
- Decide which review sources to include (up to 2).

## Run your report

1. Go to **Dashboard** -> **Intelligence**.
2. Select **Run intelligence**.
3. Complete the run form:**Current brand domain**
4. **Competitors** (exactly 3)
5. **Market**
6. **Review sources** (select up to 2)
7. If you select CSV as a source, upload your review file.
8. Select **Run intelligence** to queue the run.

## What happens while it runs

- The main action changes to **Running report**.
- The page refreshes progress automatically in the background.
- Last run timestamp updates once queued or completed.

## What you get after completion

Your Intelligence page is populated with:

- **Customer segments**
- **Positioning snapshot**
- **Messaging matrix**
- **Category baseline vs ownable angles**
- **Review intelligence**

You can then select **Download report** when the report file is ready.

## Troubleshooting

**Run button is disabled.**

- A run may already be in progress. Wait for completion, then run again.

**Queueing fails.**

- Review required fields and ensure URLs, market selection, and review-source rules are valid.
