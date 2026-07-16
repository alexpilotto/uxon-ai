#!/usr/bin/env bash
set -euo pipefail

: "${UXON_API_KEY:?Set UXON_API_KEY to a UXON API key}"
: "${UXON_SITE_ID:?Set UXON_SITE_ID to the target siteId}"
: "${UXON_EXPERIMENT_ID:?Set UXON_EXPERIMENT_ID to the experiment ID}"

curl -X POST 'https://uxon.ai/api/external/commands' \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{
    \"command\": \"reports.experiment.details\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\",
      \"experimentId\": \"${UXON_EXPERIMENT_ID}\",
      \"conversionGoalId\": \"all\"
    }
  }"
