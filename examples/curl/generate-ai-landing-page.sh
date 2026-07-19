#!/usr/bin/env bash
set -euo pipefail

: "${UXON_API_KEY:?Set UXON_API_KEY to a UXON API key}"
: "${UXON_SITE_ID:?Set UXON_SITE_ID to the target siteId}"

curl -X POST 'https://uxon.ai/api/external/commands' \
  -H "Authorization: Bearer ${UXON_API_KEY}" \
  -H 'Content-Type: application/json' \
  -d "{
    \"command\": \"landing_pages.generate_from_brief\",
    \"input\": {
      \"siteId\": \"${UXON_SITE_ID}\",
      \"name\": \"Spring Offer\",
      \"brief\": {
        \"brandName\": \"Acme Dental\",
        \"websiteUrl\": \"https://acmedental.com\",
        \"language\": \"English (US)\",
        \"funnelStrategy\": \"Service\",
        \"buyerGroup\": \"Consumers (B2C)\",
        \"desiredAction\": \"Submit a form\",
        \"market\": \"Brisbane, Queensland\",
        \"serviceOrProduct\": \"Emergency dental appointments\",
        \"idealClient\": \"Adults with urgent dental pain\"
      }
    }
  }"
