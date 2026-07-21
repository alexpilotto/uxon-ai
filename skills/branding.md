# Branding API

Inspect and adjust saved UXON sub-account branding through API-key commands or matching MCP tools.

Branding data is used by UXON when creating blank landing pages and AI-generated landing pages. Agents should treat branding as account setup data: read first, adjust only when the user explicitly asks, then read back to confirm.

## Core Commands

- `branding.get`: fetch color variables, brand colors, palettes, logos, font variables, brand voice, and readiness flags for a sub-account.
- `branding.update`: update editable branding fields: color variables, brand colors, palette name, and brand voice.

MCP tool names use underscores:

- `branding_get`
- `branding_update`

## Get Branding Overview

```json
{
  "command": "branding.get",
  "input": {
    "siteId": "site_uuid"
  }
}
```

Expected output keys:

- `data.branding.colorVariables`
- `data.branding.brandColors`
- `data.branding.colorPalettes[]`
- `data.branding.logos[]`
- `data.branding.brandVoice`
- `data.branding.fontVariables`
- `data.branding.readiness`

Example output shape:

```json
{
  "branding": {
    "colorVariables": {
      "pageBackground": "#FFFFFF",
      "headings": "#2F2217",
      "bodyText": "#343433",
      "button": "#F8C80B",
      "buttonText": "#111111",
      "lightBackground": "#F7F7E0",
      "darkBackground": "#2F2217",
      "starRating": "#FDBF01"
    },
    "brandColors": [
      "#F8C80B",
      "#947C1C",
      "#343433",
      "#AA7944",
      "#E4D3B2",
      "#2F2217",
      "#FFFFFF"
    ],
    "logos": [],
    "brandVoice": "",
    "fontVariables": null,
    "readiness": {
      "hasColorVariables": true,
      "hasBrandColors": true,
      "hasLogo": false,
      "hasBrandVoice": false,
      "hasFonts": false,
      "isReady": false
    }
  }
}
```

Readiness notes:

- `isReady` means UXON has color variables, brand colors, and at least one logo.
- `hasBrandVoice` and `hasFonts` are quality signals, not hard blockers.
- Missing logos should be handled through branding/logo workflows where available, not `branding.update`.

## Update Branding

`branding.update` is partial. Omitted fields are preserved.

```json
{
  "command": "branding.update",
  "input": {
    "siteId": "site_uuid",
    "colorVariables": {
      "pageBackground": "#FFFFFF",
      "headings": "#2F2217",
      "bodyText": "#343433",
      "button": "#F8C80B",
      "buttonText": "#111111",
      "lightBackground": "#F7F7E0",
      "darkBackground": "#2F2217",
      "starRating": "#FDBF01"
    },
    "brandColors": [
      "#F8C80B",
      "#947C1C",
      "#343433",
      "#AA7944",
      "#E4D3B2",
      "#2F2217",
      "#FFFFFF"
    ],
    "paletteName": "Brand colours",
    "brandVoice": "Clear, useful, confident, and specific. Avoid hype."
  }
}
```

Minimal partial update:

```json
{
  "command": "branding.update",
  "input": {
    "siteId": "site_uuid",
    "colorVariables": {
      "button": "#F8C80B",
      "buttonText": "#111111"
    }
  }
}
```

Editable fields:

- `colorVariables`: named landing page colors.
- `brandColors`: ordered palette array. Send only when replacing the palette.
- `paletteName`: current palette label.
- `brandVoice`: brand voice guidance text.

Preferred `colorVariables` keys:

- `pageBackground`
- `headings`
- `bodyText`
- `button`
- `buttonText`
- `lightBackground`
- `darkBackground`
- `starRating`

Existing internal/kebab-case keys are also accepted:

- `page-background`
- `body-text`
- `button-background`
- `button-text`
- `light-background`
- `dark-background`
- `star-rating`

Validation notes:

- Color values must be 3- or 6-digit hex values, with or without `#`.
- UXON normalizes saved values to uppercase `#RRGGBB`.
- `button` maps to UXON's primary button background color.
- Logo upload/import is not part of this command.

Expected output keys:

- `data.updatedFields[]`
- `data.branding`

## Safe Agent Flow

1. Run `subaccounts.list` to resolve `siteId`.
2. Run `branding.get`.
3. Summarize current readiness and notable missing fields.
4. Ask before making manual brand adjustments.
5. Run `branding.update` with only the intended fields.
6. Run `branding.get` again to confirm.

## Related Files

- [Landing pages](landing-pages.md)
- [Onboard a new client](../runbooks/onboard-new-client.md)
- [Branding cURL example](../examples/curl/branding-overview-and-update.sh)
