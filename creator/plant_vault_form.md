# Creator form setup
Create private app `JollyRx_Private_Vault`; forms `Plant_Vault` and `RFQ_Inquiries`. Do not publish Plant_Vault or reports containing it.

| Plant_Vault label | Link name | Type | Setup |
|---|---|---|---|
| Real Plant Name | Real_Plant_Name | Single Line | required, confidential |
| Factory Address | Factory_Address | Multi Line | required, confidential |
| Drug License | Drug_License | Single Line | required, confidential |
| Site Master File (SMF) | Site_Master_File | File Upload | required, confidential; attach one dummy PDF per plant |
| Region Code | Region_Code | Single Line | required private helper: BD, GJ, HP |
| Masked Node ID | Masked_Node_ID | Single Line | required, unique, read-only after generation |
| Molecule | Molecule | Single Line | internal only |
| Dosage Form | Dosage_Form | Dropdown | Tablets, Injectables |
| Certification | Certification | Dropdown | WHO-GMP, Schedule M |
| MOQ | MOQ | Number | positive integer |
| Commerce Product ID | Commerce_Product_ID | Single Line | hidden/internal |
| Sync Status | Sync_Status | Single Line | internal |

`RFQ_Inquiries` currently has `Node_ID` (required Single Line text), `Buyer_Name` (Single Line), `Email` (Email), `Target_Quantity` (Number), and `Status` (Dropdown New/In Progress/Closed, default New). No `Submitted_At` field exists. The public handler validates the Node ID against Plant_Vault and writes the masked Node ID text; no confidential plant details are copied into the inquiry.

## Mask generation workflow
Install [`generate_masked_node_id.dg`](deluge/generate_masked_node_id.dg) as a **Plant_Vault > On Success (create)** workflow. It allocates the next two-digit sequence per region and writes `NODE-<region>-<sequence>`; `Region_Code` stays private. The count-based sequence fits this three-record demo; production should use an atomic counter to avoid races.

[UI-ONLY] The live Plant_Vault and RFQ_Inquiries forms are configured; the RFQ Node_ID is text rather than a lookup. Seed records have their dummy PDFs attached; the public API handler is saved but has not yet been verified by a storefront submission. Keep all four confidential fields—Real Plant Name, Factory Address, Drug License, and SMF—inside Creator. Public Commerce products contain only Node ID, Dosage Form, Certification, and MOQ.
