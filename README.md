# JollyRx Zoho assignment

Prototype deliverables for a masked pharmaceutical CDMO catalog and RFQ flow. The live Zoho Creator trial contains the three fictional plants, private dummy SMFs, the generated Node ID workflow, and Creator fields for Commerce product ID and sync status. The Zoho Commerce trial shows the three masked catalog entries. The Creator→Commerce OAuth connection is authorized for product create/update only and enabled for this Creator app.

Start with `docs/00_architecture.md`, then `docs/48_hour_plan.md`.

All plant data and SMF PDFs are fictional. Never publish Creator confidential fields or SMF files. The Create-triggered Creator→Commerce workflow is configured with the India endpoint and tenant route ID, but has not been exercised against a new Creator record. Public RFQ Custom API, RFQ modal injection, theme polish, and public leak test still need live Zoho configuration/verification. See `qa/leak_test.md` before publishing a storefront. Do not describe this as a working two-way demo until a storefront RFQ is shown landing in Creator against its Node ID.
