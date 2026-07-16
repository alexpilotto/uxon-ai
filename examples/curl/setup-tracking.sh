#!/usr/bin/env bash
set -euo pipefail

: "${UXON_API_KEY:?Set UXON_API_KEY to a UXON API key}"
: "${UXON_SITE_ID:?Set UXON_SITE_ID to the target siteId}"
: "${UXON_DOMAIN:?Set UXON_DOMAIN to the host, for example www.example.com}"
: "${UXON_GTM_CONTAINER_ID:?Set UXON_GTM_CONTAINER_ID to the GTM container ID}"

curl -X POST 'https://uxon.ai/api/external/commands' \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{
    \"command\": \"tracking.setup\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\",
      \"mode\": \"gtm\",
      \"domain\": \"${UXON_DOMAIN}\",
      \"gtmContainerId\": \"${UXON_GTM_CONTAINER_ID}\"
    }
  }"
