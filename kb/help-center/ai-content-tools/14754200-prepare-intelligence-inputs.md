# Prepare Intelligence inputs

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Set up high-quality inputs so Intelligence output is relevant, actionable, and easier to execute.
- The quality of your Intelligence output depends on the quality of your inputs.
- Use this checklist to set up a clean run.

## Source
- Help Center: [Prepare Intelligence inputs](https://docs.uxon.ai/en/articles/14754200-prepare-intelligence-inputs)
- Source collection: AI content tools

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)
- [Reports API](../../../skills/reports.md)
- [Weekly optimization runbook](../../../runbooks/weekly-optimization.md)

## Article
The quality of your Intelligence output depends on the quality of your inputs. Use this checklist to set up a clean run.

## 1) Current brand domain

- Enter your current brand website URL.
- Use your main marketing domain to keep competitor comparison aligned.

## 2) Competitors (exactly 3)

- Add 3 direct competitors in the same category or offer space.
- Use unique domains.
- Do not include your own domain in competitor fields.

> Best practice: select competitors your ideal customers would realistically compare before buying.

## 3) Market

- Start typing and choose a country from the list.
- Use the market where your paid traffic and demand generation are focused.

## 4) Review sources (up to 2)

- Select at least one source.
- You can select up to two sources per run.
- Combine broad public reviews with CSV when you need extra context.

## 5) CSV upload (optional, required if CSV source is selected)

If you enable CSV as a source:

- File must be **.csv**
- Maximum size: **1MB**
- Maximum parsed rows: **300**
- Required column: **review_body**
- Optional columns: **name**, **date**, **rating**, **source**, **title**, **external_id**, **source_url**

Use **Download CSV example** in the modal for a ready-to-use template.

## Troubleshooting

**I cannot submit the run.**

- Check that all required fields are complete and exactly 3 competitors are present.

**CSV upload is rejected.**

- Confirm the file has a **review_body** column and at least one valid row.

**Too many review sources selected.**

- Reduce selection to a maximum of two sources.
