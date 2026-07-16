# Understand the UXON AI workspace hierarchy

Public UXON Help Center article exported as Markdown for developer and AI-agent retrieval.

## Summary
- Organizations and sub-accounts.
- UXON is built around a clear hierarchy that supports both single teams and agencies managing multiple clients with strict access separation.
- At the top level is your **Organization**, which contains **sub-accounts**, users, and shared usage.

## Source
- Help Center: [Understand the UXON AI workspace hierarchy](https://docs.uxon.ai/en/articles/13543057-understand-the-uxon-ai-workspace-hierarchy)
- Source collection: Workspace and teams

## Related UXON Guides
- [Quick start](../../../QUICKSTART.md)
- [Agent command playbook](../../../SKILLS.md)

## Article
UXON is built around a clear hierarchy that supports both single teams and agencies managing multiple clients with strict access separation.

At the top level is your **Organization**, which contains **sub-accounts**, users, and shared usage.

### Organization level

When you sign up, you create an **Organization** and become its **Owner**.

The organization is the top-level container and represents your company or agency.

It controls:

- Users and roles
- Sub-accounts
- Billing and subscription
- Total traffic usage

All users belong to an organization, but what they can see depends on their role and sub-account access.

> You can rename your organization by navigating to **[Account](https://uxon.ai/dashboard/account)** > **Subscription**, scrolling to **Organization**, updating the name, and selecting **Save**.

### Sub-account level

Sub-accounts live **inside** an organization and are used to fully separate work.

Each sub-account has its own isolated data, including:

- Landing pages
- Experiments
- Contacts
- Customer events
- Integrations and eCommerce connections
- Branding and settings
- Call tracking

Sub-accounts do **not** share data with each other. This makes them ideal for:

- Agencies managing multiple clients
- Teams running independent projects
- Separating brands, regions, or business units

### Shared vs isolated resources

The hierarchy is intentionally strict. **Isolated per sub-account**

- Pages and experiments
- Conversion data and contacts
- Integrations and pixels
- Configuration and branding

**Shared at organization level**

- Traffic usage, all sub-accounts draw from the same traffic allowance
- Users and roles

This design ensures clean data separation while keeping account management simple.

### User access in the hierarchy

Users are added at the **organization** level but access sub-accounts based on their role:

- Admins and Managers can access all sub-accounts
- Members can only access the specific sub-accounts assigned to them

This allows you to tightly control who sees what without duplicating accounts.
