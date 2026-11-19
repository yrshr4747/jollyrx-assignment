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

`RFQ_Inquiries`: `Node_ID` (Lookup to Plant_Vault, display Masked_Node_ID), `Buyer_Name` (Single Line), `Email` (Email), `Target_Quantity` (Number), `Submitted_At` (Date-Time), `Status` (Dropdown New/In Progress/Closed, default New). Lookup stores plant record ID; handler resolves submitted node string first.

## Mask generation workflow
Install [`generate_masked_node_id.dg`](deluge/generate_masked_node_id.dg) as a **Plant_Vault > On Success (create)** workflow. It allocates the next two-digit sequence per region and writes `NODE-<region>-<sequence>`; `Region_Code` stays private. The count-based sequence fits this three-record demo; production should use an atomic counter to avoid races.

[UI-ONLY] Create Plant_Vault, add fields/helper and workflow; create RFQ_Inquiries + lookup; import seed CSV, then edit each record to upload its dummy PDF (CSV cannot populate upload field). Keep all four confidential fields—Real Plant Name, Factory Address, Drug License, and SMF—inside Creator. Public Commerce products contain only Node ID, Dosage Form, Certification, and MOQ.
