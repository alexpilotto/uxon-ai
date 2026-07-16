#!/usr/bin/env bash
set -euo pipefail

: "${UXON_API_KEY:?Set UXON_API_KEY to a UXON API key}"
: "${UXON_SITE_ID:?Set UXON_SITE_ID to the target siteId}"

curl -X POST 'https://uxon.ai/api/external/commands' \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{
    \"command\": \"landing_pages.create\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\",
      \"name\": \"Spring Offer\"
    }
  }"
