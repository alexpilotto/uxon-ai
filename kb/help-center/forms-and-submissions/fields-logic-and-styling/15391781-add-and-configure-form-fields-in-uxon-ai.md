# Add and configure form fields in UXON AI

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Use field types, defaults, validation, scoring, and field actions in Form Builder.
- Fields are the questions, inputs, content, and media visitors see inside each form screen.
- Select the screen where the field should appear.

## Source
- Help Center: [Add and configure form fields in UXON AI](https://docs.uxon.ai/en/articles/15391781-add-and-configure-form-fields-in-uxon-ai)
- Source collection: Forms and submissions / Fields, logic, and styling

## Related UXON Guides
- [Contacts API](../../../../skills/contacts.md)
- [Conversion tracking API](../../../../skills/conversion-tracking.md)

## Article
Fields are the questions, inputs, content, and media visitors see inside each form screen.

## Add a field

1. Open a form in Form Builder.
2. Select the screen where the field should appear.
3. Choose a field from the left sidebar, or select **Add field to screen**.
4. Select the field to open **Field settings**.

## Available field types

- **Essentials**: Short Text, Long Text, Single Selection, Multiple Selection, Number, Date, Content.
- **Contact Details**: Full Name, Email, Phone, Address, Website URL, Consent, Hidden Field.
- **Uploads and Media**: File Upload, Image, Video.

## Configure field basics

In **Field settings**, you can update:

- **Field type**
- **Screen**, if the field needs to move to another step
- **Required**
- **Hidden**
- **Name fields** for Full Name fields
- **Options** for selection fields

## Defaults, validation, and scoring

- **Default answer**: pre-fill supported fields or set default selected options.
- **Validation**: set length, number, date, selection, file type, and pattern rules where supported.
- **Scoring**: assign scores to answer fields or individual options.

## Field actions

Use the field action menu to hide, duplicate, move, or remove fields.

> File upload fields currently capture the selected file name. Do not use them as file storage unless your workflow has a separate upload destination.

## Troubleshooting

**I cannot remove a field.**

- A form must keep at least one field across all screens.

**Validation keeps failing.**

- Check the field type, required setting, and validation rules. Pattern validation must use a valid regular expression.
