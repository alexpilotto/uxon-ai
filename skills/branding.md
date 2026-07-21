# Branding API

Inspect and adjust saved UXON sub-account branding through API-key commands or matching MCP tools.

Branding data is used by UXON when creating blank landing pages and AI-generated landing pages. Agents should treat branding as account setup data: read first, adjust only when the user explicitly asks, then read back to confirm.

## Core Commands

- `branding.get`: fetch color variables, brand colors, logo URLs, palettes, font variables, custom fonts, brand voice, and readiness flags for a sub-account.
- `branding.update`: update editable branding fields: color variables, brand colors, logo URLs, font variables, custom font URL imports, palette name, and brand voice.

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
- `data.branding.logo`
- `data.branding.colorPalettes[]`
- `data.branding.logos[]`
- `data.branding.brandVoice`
- `data.branding.fonts`
- `data.branding.fontVariables`
- `data.branding.customFonts[]`
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
    "logo": {
      "light": "https://example.com/logo-light.svg",
      "dark": "https://example.com/logo-dark.svg",
      "favicon": "https://example.com/favicon.png"
    },
    "logos": [],
    "brandVoice": "",
    "fonts": {
      "headings": {
        "fontFamily": "Inter",
        "fontWeight": "700 - Bold",
        "uppercase": false,
        "google": true
      },
      "bodyText": {
        "fontFamily": "Inter",
        "fontWeight": "400 - Regular",
        "uppercase": false,
        "google": true
      },
      "buttons": {
        "fontFamily": "",
        "fontWeight": "500 - Medium",
        "uppercase": false,
        "google": false,
        "source": "heading"
      }
    },
    "fontVariables": {
      "headings": {
        "fontFamily": "Inter",
        "fontWeight": "700 - Bold",
        "uppercase": false,
        "google": true
      },
      "bodyText": {
        "fontFamily": "Inter",
        "fontWeight": "400 - Regular",
        "uppercase": false,
        "google": true
      },
      "buttons": {
        "fontFamily": "",
        "fontWeight": "500 - Medium",
        "uppercase": false,
        "google": false,
        "source": "heading"
      },
      "updatedAt": "2026-07-21T00:00:00.000Z"
    },
    "customFonts": [],
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
- `logo.light` is the light-coloured or white logo variant used on dark backgrounds.
- `logo.dark` is the dark-coloured logo variant used on light backgrounds.
- `logo.favicon` is the square icon used for browser/app metadata.

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
    "logo": {
      "light": "https://example.com/logo-light.svg",
      "dark": "https://example.com/logo-dark.svg",
      "favicon": "https://example.com/favicon.png"
    },
    "fonts": {
      "headings": {
        "fontFamily": "Inter",
        "fontWeight": "700 - Bold",
        "uppercase": false,
        "google": true
      },
      "bodyText": {
        "fontFamily": "Inter",
        "fontWeight": "400 - Regular",
        "uppercase": false,
        "google": true
      },
      "buttons": {
        "source": "heading",
        "fontWeight": "600 - Semi-Bold",
        "uppercase": false
      }
    },
    "customFonts": [
      {
        "name": "Brand Sans",
        "variants": [
          {
            "url": "https://cdn.example.com/fonts/brand-sans-400.woff2",
            "weight": "400",
            "style": "Normal"
          },
          {
            "url": "https://cdn.example.com/fonts/brand-sans-700.woff2",
            "weight": "700",
            "style": "Normal"
          }
        ]
      }
    ],
    "paletteName": "Brand colours",
    "brandVoice": "Clear, useful, confident, and specific. Avoid hype."
  }
}
```

Partial update example:

```json
{
  "command": "branding.update",
  "input": {
    "siteId": "site_uuid",
    "colorVariables": {
      "button": "#F8C80B",
      "buttonText": "#111111"
    },
    "logo": {
      "dark": "https://example.com/logo-dark.svg"
    },
    "fonts": {
      "buttons": {
        "source": "heading",
        "fontWeight": "600 - Semi-Bold"
      }
    }
  }
}
```

Editable fields:

- `colorVariables`: named landing page colors.
- `brandColors`: ordered palette array. Send only when replacing the palette.
- `logo`: direct HTTP/HTTPS image URLs by role.
- `fonts`: heading/body/button font variables. Supported slots are `headings`, `bodyText`, and `buttons`. Each slot accepts `fontFamily`, `fontWeight`, `uppercase`, `google`, and for buttons `source: "heading" | "body"`.
- `customFonts`: custom font URL imports. Each font needs a `name` and one or more direct `.woff2`, `.woff`, `.ttf`, or `.otf` URLs. UXON imports and hosts successful files.
- `paletteName`: current palette label.
- `brandVoice`: brand voice guidance text.

Logo role meaning:

- `logo.light`: light-coloured or white logo used on dark backgrounds.
- `logo.dark`: dark-coloured logo used on light backgrounds.
- `logo.favicon`: square browser/app icon.

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
- Logo values must be direct HTTP/HTTPS image URLs.
- Omitted logo roles are preserved.
- Font weights can use UXON labels such as `400 - Regular` and `700 - Bold`, or numeric weights such as `400` and `700`.
- Omitted font slots are preserved.
- Use the web app or dedicated logo workflows for binary file uploads when no direct image URL exists.
- Use the web app or dedicated font upload workflow for binary font uploads when no direct font URL exists.

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
