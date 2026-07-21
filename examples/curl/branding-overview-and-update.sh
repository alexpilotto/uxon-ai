#!/usr/bin/env bash
set -euo pipefail

: "${UXON_API_KEY:?Set UXON_API_KEY to your UXON API key}"
: "${UXON_SITE_ID:?Set UXON_SITE_ID to the target sub-account/site ID}"

UXON_API_BASE="${UXON_API_BASE:-https://uxon.ai}"
COMMAND_URL="${UXON_API_BASE}/api/external/commands"

echo "Reading current branding overview..."
curl -sS -X POST "${COMMAND_URL}" \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"branding.get\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\"
    }
  }"

echo
echo "Applying a partial branding update..."
curl -sS -X POST "${COMMAND_URL}" \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"branding.update\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\",
      \"colorVariables\": {
        \"button\": \"#F8C80B\",
        \"buttonText\": \"#111111\"
      },
      \"logo\": {
        \"dark\": \"https://example.com/logo-dark.svg\"
      },
      \"brandVoice\": \"Clear, useful, confident, and specific. Avoid hype.\"
    }
  }"

echo
echo "Reading branding again to confirm saved values..."
curl -sS -X POST "${COMMAND_URL}" \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "{
    \"command\": \"branding.get\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\"
    }
  }"

echo
