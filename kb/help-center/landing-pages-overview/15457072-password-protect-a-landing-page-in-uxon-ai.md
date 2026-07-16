# Password protect a landing page in UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Add a password gate to a published landing page and customize how visitors unlock it.
- Use password protection when a published landing page should only be viewed by people who know the password.
- This is useful for client review links, private campaign previews, partner pages, or limited-access offers.

## Source
- Help Center: [Password protect a landing page in UXON AI](https://docs.uxon.ai/en/articles/15457072-password-protect-a-landing-page-in-uxon-ai)
- Source collection: Landing pages overview

## Related UXON Guides
- [Landing pages API](../../../skills/landing-pages.md)
- [Create a landing page with cURL](../../../examples/curl/create-landing-page.sh)
- [Import code pages guide](../../landing-pages/import-code-pages.md)

## Article
Use password protection when a published landing page should only be viewed by people who know the password. This is useful for client review links, private campaign previews, partner pages, or limited-access offers.

## Before you start

- Open the correct client account and landing page.
- Choose a password you are comfortable sharing with the intended viewers.
- Remember that password protection controls page access, but it is not a replacement for account login, payments, or secure document storage.

## Turn on password protection

1. Go to **Dashboard** > **Landing pages**.
2. Open the landing page you want to protect.
3. Open the page actions menu.
4. Select **Password protection**.
5. Enter a password.
6. Turn on **Enable password protection**.
7. Select **Save**.

Password protection applies to the live landing page after the setting is saved. If the page is not published yet, publish it before sharing the protected URL.

## Customize the password gate

The gate is the screen visitors see before the landing page unlocks. You can customize:

- **Gate title**
- **Gate body**
- **Button label**
- **Invalid password text**
- **Background color**
- **Text color**
- **Button color**

Use simple copy that tells visitors what to do, for example "This page is protected" and "Enter the password to continue."

## Allow unlock from a URL parameter

You can let a page unlock automatically when the password is included in the URL. This is useful for review links where you do not want the viewer to type the password manually.

1. Keep **Allow automatic unlock from a URL parameter** enabled.
2. Set the **URL parameter key**. The default key is `psw`.
3. Share the page URL with the parameter and password value.

Example: `https://your-page.com?psw=your-password`

Only use automatic unlock links with trusted viewers. The password is visible in the URL, so anyone with that link can open the page while the password is valid.

## What visitors experience

- Visitors see the password gate before they can view the page.
- If the password is wrong, they see the invalid password text you configured.
- If the password is correct, the page unlocks in that browser for a limited time.
- If you change the password, visitors need the new password to unlock the page again.

## Test before sharing

1. Open the protected page in a private or incognito browser window.
2. Confirm the gate appears.
3. Try an incorrect password and confirm the error message appears.
4. Enter the correct password and confirm the page unlocks.
5. If you use URL parameter unlock, test the full shared URL before sending it to reviewers.

## Troubleshooting

**I cannot enable password protection.**

- Enter a password first, then enable password protection and save.

**The URL parameter does not unlock the page.**

- Confirm automatic unlock from a URL parameter is enabled.
- Confirm the URL parameter key matches the key in settings.
- Confirm the password value in the URL matches the current page password.

**Visitors still see the gate after entering the password.**

- They may be using a different browser, device, or private window.
- Their unlock session may have expired.
- The page password may have been changed after they unlocked the page.

**Someone who should not have access can still open the page.**

- Change the password, save the setting, and share the new password only with intended viewers.
