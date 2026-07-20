# API/MCP Production Smoke Test

Use this checklist after UXON API/MCP changes are deployed.

## Test Accounts

- Use `PICA Group` only for read-only performance analytics:
  - landing page reports
  - experiment reports
  - account summaries that need real traffic numbers
- Use `Test Account` for every create, update, duplicate, variant, draft experiment, docs, and validation-error test.
- Name all created test resources with `MCP/API QA - Delete Me - YYYY-MM-DD`.
- Do not publish pages or start experiments during this smoke test unless that exact behavior is being tested deliberately.

## Claude MCP Test Sequence

1. Run `uxon_healthcheck`.
   Expected: correct team/org context.

2. Run `tools/list`.
   Expected: write tools show `confirm` where required, create-style tools show required `idempotencyKey`, and ID-based tools show accepted one-of fields such as `landingPageId` or `id`.

3. Run `subaccounts_list`.
   Expected: returns the full organisation roster, including `PICA Group` and `Test Account`.

4. On `PICA Group`, run `reports_landing_pages_summary` for `last-7-days`.
   Expected: current page inventory plus real pixel-backed sessions/conversions/revenue where traffic exists.

5. On `PICA Group`, run `reports_experiments_summary` or `experiments_list`.
   Expected: experiment inventory and live pixel-backed totals where experiments have activity.

6. On `Test Account`, run `landing_pages_list`.
   Expected: returns landing pages and IDs without touching PICA data.

7. On `Test Account`, run `landing_pages_create` with a test name, `confirm: true`, and a stable `idempotencyKey`.
   Expected: draft landing page with a blank/default variant.

8. On `Test Account`, run `landing_pages_get` for the new page.
   Expected: metadata, variant data, and preview URLs.

9. On `Test Account`, run `landing_pages_update` to rename the page.
   Expected: name changes and can be read back.

10. On `Test Account`, run `landing_pages_variants_create`.
    Expected: new variant is created.

11. On `Test Account`, run `landing_pages_variants_duplicate`.
    Expected: duplicate variant is created.

12. On `Test Account`, run `landing_pages_duplicate`.
    Expected: duplicate landing page is created.

13. On `Test Account`, run `experiments_create` as `Draft` only.
    Expected: draft experiment is created without launch.

14. On `Test Account`, run `experiments_get`.
    Expected: setup, goals, targeting, filters, and live all-time totals fields are returned.

15. Run one intentional bad MCP write call, such as `landing_pages_create` without `confirm` or without `idempotencyKey`.
    Expected: clear structured tool error, not a generic connector failure.

## API Agent Test Sequence

Use `POST https://uxon.ai/api/external/commands` for commands.

1. Fetch `GET https://uxon.ai/api/skills`.
   Expected: latest public skill/playbook loads without auth.

2. Run `subaccounts.list`.
   Expected: full accessible account list, including `PICA Group` and `Test Account`.

3. On `PICA Group`, run `reports.landing_pages.summary` with `dateRange: "last-7-days"`.
   Expected: real pixel-backed report numbers.

4. On `PICA Group`, run `reports.experiments.summary` or `experiments.list`.
   Expected: experiment data and live totals where available.

5. On `Test Account`, run `landing_pages.create`.
   Expected: draft landing page created. Direct API does not use MCP `confirm` or `idempotencyKey`.

6. On `Test Account`, run `landing_pages.get`.
   Expected: created landing page details and variant data.

7. On `Test Account`, run `landing_pages.update`.
   Expected: renamed landing page.

8. On `Test Account`, run `landing_pages.variants.create`.
   Expected: variant created.

9. On `Test Account`, run `landing_pages.variants.duplicate`.
   Expected: duplicate variant created.

10. On `Test Account`, run `landing_pages.duplicate`.
    Expected: duplicate landing page created.

11. On `Test Account`, run `experiments.create` as draft only.
    Expected: draft experiment created.

12. On `Test Account`, run `experiments.get`.
    Expected: setup plus live all-time totals fields are returned.

13. On `Test Account`, run `reports.experiment.details` for the draft experiment.
    Expected: report command responds cleanly even if the draft has no traffic yet.

14. Run `docs.search`, then `docs.get`.
    Expected: help articles can be searched and retrieved.

15. Run one intentional bad API payload, such as a command missing `siteId`.
    Expected: clear validation error.

## Pass Criteria

- MCP can see the full organisation, not only one active sub-account.
- PICA Group read-only analytics return live pixel-backed data where traffic exists.
- Test Account write operations create, update, duplicate, and read back resources correctly.
- Draft experiment creation works without accidental launch.
- Bad calls return clear validation/confirmation/idempotency errors.
- Public skills and API/MCP schemas tell agents what to send without guessing.
