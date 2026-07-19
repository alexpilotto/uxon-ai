#!/usr/bin/env bash
set -euo pipefail

: "${UXON_API_KEY:?Set UXON_API_KEY to a UXON API key}"
: "${UXON_SITE_ID:?Set UXON_SITE_ID to the target siteId}"
: "${UXON_GOAL_ID:?Set UXON_GOAL_ID to the selected conversion goal ID}"
: "${UXON_CONTROL_LP_ID:?Set UXON_CONTROL_LP_ID to the control landing page ID}"
: "${UXON_CONTROL_VARIANT_ID:?Set UXON_CONTROL_VARIANT_ID to the control variant ID}"
: "${UXON_VARIANT_LP_ID:?Set UXON_VARIANT_LP_ID to the variant landing page ID}"
: "${UXON_VARIANT_VARIANT_ID:?Set UXON_VARIANT_VARIANT_ID to the variant variant ID}"

curl -X POST 'https://uxon.ai/api/external/commands' \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{
    \"command\": \"experiments.create\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\",
      \"nickname\": \"Headline Test\",
      \"selectedGoals\": [
        { \"id\": \"${UXON_GOAL_ID}\", \"name\": \"Lead\" }
      ],
      \"controlSource\": \"uxon\",
      \"controlLandingPage\": \"${UXON_CONTROL_LP_ID}\",
      \"controlVariant\": \"${UXON_CONTROL_VARIANT_ID}\",
      \"variantSource\": \"uxon\",
      \"variantLandingPage\": \"${UXON_VARIANT_LP_ID}\",
      \"variantVariant\": \"${UXON_VARIANT_VARIANT_ID}\",
      \"testTrigger\": \"entry\",
      \"visitorType\": \"all-visitors\",
      \"deviceType\": \"all-devices\",
      \"trafficAllocation\": 100
    }
  }"
