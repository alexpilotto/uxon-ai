# Use conditional logic in UXON AI forms

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Show fields only when earlier answers match the conditions you choose.
- Conditional logic lets you show a field only when a visitor has given a relevant earlier answer.
- When to use conditional logic Ask follow-up questions only when they apply.

## Source
- Help Center: [Use conditional logic in UXON AI forms](https://docs.uxon.ai/en/articles/15391784-use-conditional-logic-in-uxon-ai-forms)
- Source collection: Forms and submissions / Fields, logic, and styling

## Related UXON Guides
- [Contacts API](../../../../skills/contacts.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)

## Article
Conditional logic lets you show a field only when a visitor has given a relevant earlier answer.

## When to use conditional logic

- Ask follow-up questions only when they apply.
- Keep short forms focused for visitors who do not need extra questions.
- Collect richer qualification data from high-intent answers.

## Set up conditional logic

1. Open the form in Form Builder.
2. Select the field you want to show conditionally.
3. In **Field settings**, go to **Logic**.
4. Turn on **Show this field conditionally**.
5. Choose the earlier field to evaluate under **Show when**.
6. Choose the condition and value.
7. Save or publish the form.

## Supported conditions

- **Equals**: answer exactly matches the value.
- **Does not equal**: answer does not match the value.
- **Contains**: answer includes the value.
- **Is answered**: the source field has a response.
- **Is empty**: the source field has no response.

## Which fields can be source fields

The source field must appear before the conditional field. Content, hidden field, image, video, and file upload fields cannot be used as logic sources.

> Conditional logic controls field visibility. It does not currently route visitors to different destination screens.

## Troubleshooting

**I cannot choose a source field.**

- Add an answer field before the conditional field. Source fields must come earlier in the form.

**The field never appears.**

- Check the selected source field, operator, and value. For selection fields, use the option value from the dropdown.
