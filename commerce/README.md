# Commerce setup and fallback
Preferred: Creator Deluge sync, only after confirming current tenant's product create scope, required variants/rate/stock schema and response mapping in official docs. [Products](https://www.zoho.com/commerce/api/products.html) · [Multiple DCs](https://www.zoho.com/commerce/api/multiple-data-centers.html)

Fallback: Commerce > Products > Import, using `products.csv`. This demonstrates masked catalog only; it does **not** implement Creator-to-Commerce sync. Do not import Creator seed data. [UI-ONLY] Create/publish store and products. Ensure only four public attributes and generic title/SEO. If product setup forces visible pricing, verify no API/source exposure before publish.
