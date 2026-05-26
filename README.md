<div align="center">

# 🧠 Founder Customer Intelligence System
### D2C Customer Intelligence Engine

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![PowerBI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Records](https://img.shields.io/badge/Records-3%2C900%2B-00C2D1?style=for-the-badge&logo=databricks&logoColor=white)
![Coverage](https://img.shields.io/badge/Coverage-50%20US%20States-378ADD?style=for-the-badge&logo=google-maps&logoColor=white)
![IIT Guwahati](https://img.shields.io/badge/IIT%20Guwahati-Summer%20Project%202025-F4B942?style=for-the-badge&logo=academia&logoColor=white)

**Strategic customer intelligence designed to identify loyalty strength, promotional dependency, and retention opportunities across customer segments and regions.**

*Retention Strategy · Loyalty Intelligence · Promotional Dependency Analytics*

</div>

---

## 👥 Team

| Member | Role |
|---|---|
| **Akshit Sukhija** | Product Intelligence & Strategic Analytics |
| **Bhumika Singhal** | Analytics Validation & Visualization |

---

## 📌 Project Overview

This project builds a **founder-level customer intelligence system** for a D2C fashion brand with 3,900+ customer records spanning 50 US states. Rather than shallow reporting, the system translates raw transactional data into commercially meaningful retention strategy.

The pipeline answers three core business questions:
- **Who are genuinely loyal customers** vs. those who only buy with discounts?
- **Which customer segments are margin-destructive** due to promo dependency?
- **Where are the strongest organic demand regions** for sustainable growth?

---

## 🗂️ Repository Structure

```
Founder-Customer-Intelligence-System/
│
├── 📁 dataset/
│   ├── customer_shopping_data.csv                      ← Raw input dataset (3,900+ records)
│   ├── refined_customer_intelligence_engine_output.csv ← Processed analytical dataset
│   └── README.md
│
├── 📁 python/
│   └── D2C_Customer_Intelligence_Engine.ipynb        ← Full analysis notebook
│   └── README.md
|
├── 📁 SQL/
│   ├── queries.sql                                     ← All 5 business intelligence queries
│   ├── D2C_SQL_Analysis_Report.pdf                     ← Full SQL report
│   └── README.md
│
├── 📁 PowerBI/
│   ├── Founder_Customer_Intelligence.pbix              ← 4-panel founder dashboard
│   └── README.md
│
└── README.md                                           ← This file
```

---

## 📊 Dataset

Two files live in the `dataset/` folder — the raw input and the processed output of the Python pipeline.

**`customer_shopping_data.csv`** — 3,900+ raw customer records across 50 US states, 4 product categories, and 4 seasons. Contains 19 original columns covering demographics, transactions, promotions, and behavioral signals.

**`refined_customer_intelligence_engine_output.csv`** — the analytics-ready output used by both SQL and Power BI. Adds 7 engineered features on top of the original 19 columns:

| Feature | Range | Purpose |
|---|---|---|
| `Loyalty_Score_A` | 0 – 1 | Behavioral loyalty (frequency, satisfaction, promo independence, diversity) |
| `Loyalty_Score_B` | 0 – 1 | Commercial loyalty (spend + purchase history) |
| `Promo_Dependency_Score` | 0, 0.5, 1 | Discount reliance detection |
| `Purchase_Intensity_Score` | 0 – 1 | Normalized repeat purchase rate |
| `Review_Satisfaction_Score` | 0 – 1 | Customer satisfaction proxy |
| `Frequency_Category_Score` | 0 – 1 | Purchase regularity signal |
| `Master_Customer_Segment` | 5 labels | Strategic customer grouping |

→ See `dataset/README.md` for the full column reference and workflow diagram.

---

## 🐍 Python

**`python/D2C_Customer_Intelligence_Engine.ipynb`** — the core processing and intelligence notebook. It runs the full pipeline from raw CSV to the analytics-ready export: data cleaning → feature engineering → dual loyalty framework design → master segmentation → strategic validation → final CSV export.

→ See the notebook for full pipeline documentation, scoring formulas, and segment logic.

---

## 🗄️ SQL

**`SQL/queries.sql`** — 5 production-grade business intelligence queries run against the processed dataset.

| # | Query | Business Question |
|---|---|---|
| Q1 | Loyal vs Promo Buyers | Who are genuinely loyal vs. discount-only buyers? |
| Q2 | Regional Organic Demand | Which US states show the strongest organic loyalty? |
| Q3 | Category Retention Analysis | Which product categories retain customers best? |
| Q4 | Segment Spend Intelligence | How does average spend differ across segments? |
| Q5 | Premium Loyalist Identification | Top-tier, low-promo, high-spend customer list |

→ See `SQL/README.md` and `SQL/D2C_SQL_Analysis_Report.pdf` for query explanations and full results.

---

## 📊 Power BI Dashboard

**`PowerBI/Founder_Customer_Intelligence.pbix`** — a 4-panel founder intelligence dashboard powered by the processed dataset.

| KPI | Value |
|---|---|
| Retention Health Score | **0.56 / 1.0** |
| Promo Dependency Risk | **0.43** ⚠️ Moderate |
| Premium Loyalist % | **36.4%** (1,420 of 3,863) |
| Organic Demand Regions | **50 states** tracked |

Panels cover: Customer Base Distribution · Organic Loyalty vs Discount Reliance scatter · Category Retention Funnel · Top 10 Strategic Regions. Filterable by Gender, Season, Category, Segment, and Subscription Status.

→ See `PowerBI/README.md` and `PowerBI/Dashboard_Screenshots/` for visuals and panel descriptions.

---

## 💡 Key Findings

**Founder Risk Signals**
- Discount Survivors (1,640 customers) carry promo dependency of 1.00 — sustained margin instability
- Certain regions show strong spend but high promo reliance — fragile, not organic revenue
- Premium Loyalists show zero promo dependency — the most reliable long-term retention base

**Strategic Actions**
- Reduce blanket discounting in vulnerable segments to protect margins
- Prioritize organic loyalty retention programs for Premium Loyalists
- Expand into high-spend, low-promo regions for sustainable growth

---

## 📈 Project Philosophy

> *"Business usefulness over technical complexity — translating raw transactional data into commercially meaningful customer intelligence instead of shallow reporting."*

---

<div align="center">

**Founder Customer Intelligence System**
*Launched by IIT Guwahati — Summer Project 2025*

Powered by Python · SQL · Power BI

</div>
