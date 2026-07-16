# Select ad accounts and import Opportunity data

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Choose the right ad accounts and import campaign data into Opportunities.
- After connecting Google Ads or Meta Ads, select which ad accounts UXON should use for Opportunities.
- When account selection is required If multiple ad accounts are available, UXON may require account selection before importing campaign data.

## Source
- Help Center: [Select ad accounts and import Opportunity data](https://docs.uxon.ai/en/articles/14753944-select-ad-accounts-and-import-opportunity-data)
- Source collection: Experiments and optimization

## Related UXON Guides
- [Experiments API](../../../skills/experiments.md)
- [Launch an A/B test runbook](../../../runbooks/launch-ab-test.md)
- [Cross-domain experiment runbook](../../../runbooks/cross-domain-experiment.md)
- [External-page experiments guide](../../experiments/external-page-experiments.md)

## Article
After connecting Google Ads or Meta Ads, select which ad accounts UXON should use for Opportunities.

## When account selection is required

If multiple ad accounts are available, UXON may require account selection before importing campaign data.

## Select Google Ads accounts

1. Go to **Opportunities** and select **Manage Ad Accounts**.
2. On the Google Ads card, select **Select Accounts**.
3. Search and choose the accounts you want to include.
4. If prompted, choose the **Manager account for linked clients**.
5. Select **Save Selection**.

## Select Meta Ads accounts

1. In **Manage Ad Accounts**, open Meta Ads **Select Accounts**.
2. Choose one or more ad accounts.
3. Select **Save Selection**.

## Import and refresh data

- After saving selection, UXON imports a campaign snapshot automatically.
- Use **Refresh** to pull the latest snapshot manually.
- Use date range filters (**Last 7, 14, 30, or 90 days**) to change analysis view.

## Troubleshooting

**You see a warning to select accounts.**

- Open **Manage Ad Accounts**, choose at least one account, and save.

**No rows are imported.**

- Confirm the selected account has recent campaign activity in the chosen date range.
- Run **Refresh** and check connection warnings in Opportunities.
