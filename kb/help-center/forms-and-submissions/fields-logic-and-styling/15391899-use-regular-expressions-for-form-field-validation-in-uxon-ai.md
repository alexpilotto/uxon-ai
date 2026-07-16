# Use regular expressions for form field validation in UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Use regex patterns to require specific answer formats in UXON AI forms.
- Regular expressions, often called regex, let you require a form answer to match a specific text pattern.
- Use them when the built-in field types and validation settings are not specific enough for the format you need.

## Source
- Help Center: [Use regular expressions for form field validation in UXON AI](https://docs.uxon.ai/en/articles/15391899-use-regular-expressions-for-form-field-validation-in-uxon-ai)
- Source collection: Forms and submissions / Fields, logic, and styling

## Related UXON Guides
- [Contacts API](../../../../skills/contacts.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)

## Article
Regular expressions, often called regex, let you require a form answer to match a specific text pattern. Use them when the built-in field types and validation settings are not specific enough for the format you need.

## When to use regular expressions

- You need an internal reference format, such as `ABC-1234`.
- You need an exact number of digits.
- You need uppercase letters only, numbers only, or a fixed prefix.
- You need a URL or code to match your own business rule.

For common formats, use the matching field type first. For example, use **Email** for email addresses, **Website URL** for URLs, **Number** for numeric answers, and **Date** for dates.

## Add a pattern to a form field

1. Open the form in Form Builder.
2. Select the field you want to validate.
3. In **Field settings**, go to **Validation**.
4. In **Pattern**, enter the regular expression pattern.
5. Save or publish the form.
6. Preview the form and test accepted and rejected examples.

## Important rules

- Enter the pattern only. Do not wrap it in forward slashes. Use `^[A-Z]+$`, not `/^[A-Z]+$/`.
- UXON AI uses JavaScript regular expression syntax.
- Use `^` at the start and `$` at the end when the whole answer must match.
- Without `^` and `$`, the pattern may match only part of the answer.

> Most form validation patterns should start with `^` and end with `$`. This prevents partial matches from passing unexpectedly.

## Copy-paste examples

| Use case | Pattern | Example accepted |
| --- | --- | --- |
| Letters only | `^[A-Za-z]+$` | `Alex` |
| Letters and spaces | `^[A-Za-z ]+$` | `Alex Pilot` |
| Numbers only | `^\d+$` | `12345` |
| Exactly 5 digits | `^\d{5}$` | `90210` |
| US ZIP code | `^\d{5}(-\d{4})?$` | `90210` or `90210-1234` |
| Uppercase letters and numbers | `^[A-Z0-9]+$` | `AB123` |
| Code with fixed prefix | `^CODE-\d{4}$` | `CODE-1234` |
| Simple phone format | `^\+?[0-9 ()-]{7,20}$` | `+1 555-0100` |
| Must start with https:// | `^https:\/\/.+$` | `https://example.com` |

## How to read common regex symbols

- `^`: start of the answer.
- `$`: end of the answer.
- `\d`: any digit from 0 to 9.
- `+`: one or more of the previous item.
- `*`: zero or more of the previous item.
- `?`: optional.
- `{5}`: exactly 5 of the previous item.
- `{7,20}`: between 7 and 20 of the previous item.
- `[A-Z]`: any uppercase letter from A to Z.
- `[A-Za-z ]`: uppercase letters, lowercase letters, or spaces.

## A safe workflow

1. Write three examples that should pass.
2. Write three examples that should fail.
3. Start with the simplest pattern that handles those examples.
4. Add `^` and `$` if the full answer must match.
5. Preview the form and test every example before sending traffic to the page.

## Troubleshooting

**Valid answers are failing.**

- Remove forward slashes if you added them around the pattern.
- Check that spaces, hyphens, and uppercase or lowercase letters are allowed where needed.
- Temporarily simplify the pattern, then add rules back one at a time.

**Invalid answers are passing.**

- Add `^` and `$` so the whole answer must match.
- Check whether `*` should be `+`. The `*` symbol allows zero matches.

**The form says the pattern is invalid.**

- Check for unmatched brackets, parentheses, or braces.
- Use a simpler pattern first, then rebuild it carefully.
