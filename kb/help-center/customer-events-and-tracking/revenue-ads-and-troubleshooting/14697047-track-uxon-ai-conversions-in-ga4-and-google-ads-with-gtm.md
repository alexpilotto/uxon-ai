# Track UXON AI conversions in GA4 and Google Ads with GTM

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Track UXON AI lead and interaction events in GA4 and Google Ads by importing a preconfigured Tag Manager container and updating the required IDs.
- UXON AI automatically tracks lead events when you use the built-in contact form template.
- To send those events to GA4 and Google Ads, import the UXON AI Tag Manager container and configure it.

## Source
- Help Center: [Track UXON AI conversions in GA4 and Google Ads with GTM](https://docs.uxon.ai/en/articles/14697047-track-uxon-ai-conversions-in-ga4-and-google-ads-with-gtm)
- Source collection: Customer events and tracking / Revenue, ads, and troubleshooting

## Related UXON Guides
- [Conversion tracking API](../../../../skills/conversion-tracking.md)
- [Set up tracking with cURL](../../../../examples/curl/setup-tracking.sh)
- [Enhanced conversions with GTM](../../../tracking/enhanced-conversions-gtm.md)

## Article
Track UXON AI lead and interaction events in GA4 and Google Ads by importing a preconfigured Tag Manager container and updating the required IDs.

UXON AI automatically tracks lead events when you use the built-in contact form template. To send those events to GA4 and Google Ads, import the UXON AI Tag Manager container and configure it.

### Import the UXON AI container into Google Tag Manager

Please download the file at the bottom of this article. Once done, proceed below:

1. Login to [Google Tag Manager](https://tagmanager.google.com/)
2. Select the correct account.
3. Click **Admin**.
4. Click **Import Container**.
5. Upload the UXON AI container file.
6. Choose **Existing workspace.**
7. Select **Merge** as the import option.
8. Select **Overwrite conflicting tags** (only if required).
9. Click **Confirm**.

This adds UXON AI tracking tags to your existing setup. Next, update your Pixel ID and GA4 Measurement ID.

### Step 1: UXON AI pixel for attribution & A/B testing

1. Navigate to **Tags** from the left sidebar
2. Open the tag "**TAG - UXON AI - Pixel Install**"
3. Replace `YOUR_PIXEL_ID` with your Pixel ID [from the dashboard](https://uxon.ai/dashboard/event-tracking).\
4. Click **Save**

### Step 2: Send form submission conversions to GA4

1. Navigate to **Tags** from the left sidebar
2. Open the tag "**EVENT - GA4 - UXON AI - Form Submit**"
3. Replace `#{{YOUR_MEASUREMENT_ID}}` with your GA4 Measurement ID
4. Click **Save**

This sends a conversion event to GA4 every time a UXON AI form is submitted.

> Each form submission triggers a `lead` event in the dataLayer, including all form field values as variables.

### Step 3 [Optional]: Track phone call clicks in UXON AI

If you want to track phone calls in the UXON AI page or experiment analytics, simply publish the tag "**EVENT - UXON AI - Phone Click**".

This tracks when users click phone numbers on your landing page. UXON AI records these as call interactions in your analytics.

### Notes

- Use Preview mode in Google Tag Manager to verify all tags fire correctly before publishing.
- Make sure your GA4 property is already set up before completing Step 2.
