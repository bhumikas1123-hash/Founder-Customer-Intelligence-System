# 📊 Dataset

<div align="center">

![Dataset](https://img.shields.io/badge/Records-3%2C900%2B-00C2D1?style=for-the-badge&logo=databricks&logoColor=white)
![Format](https://img.shields.io/badge/Format-CSV-49B675?style=for-the-badge&logo=files&logoColor=white)
![Source](https://img.shields.io/badge/Source-D2C%20Fashion%20Brand-F4B942?style=for-the-badge&logo=shopify&logoColor=white)
![States](https://img.shields.io/badge/Coverage-50%20US%20States-378ADD?style=for-the-badge&logo=google-maps&logoColor=white)

**This folder contains both the raw customer transaction dataset and the processed analytical dataset used throughout the customer retention intelligence pipeline.**

</div>

---

## 🔄 Dataset Workflow

```
customer_shopping_data.csv          customer_intelligence_final.csv
         │                                        ▲
         │   ┌─────────────────────────────────┐  │
         │   │        Python Notebook          │  │
         └──▶│  • Data Cleaning                │──┘
             │  • Feature Engineering          │
             │  • Loyalty Scoring              │
             │  • Segment Classification       │
             │  • Promo Dependency Scoring     │
             └─────────────────────────────────┘
```

The datasets support the complete workflow of:

| Stage | Dataset Used | Purpose |
|---|---|---|
| 🧹 Cleaning | `customer_shopping_data.csv` | Remove nulls, fix types, rename columns |
| ⚙️ Engineering | `customer_shopping_data.csv` | Build loyalty, promo, intensity scores |
| 🧠 Segmentation | `customer_shopping_data.csv` | Assign Master Customer Segment labels |
| 🗄️ SQL Analysis | `refined_customer_intelligence_engine_output.csv` | Run 5 business intelligence queries |
| 📊 Dashboard | `refined_customer_intelligence_engine_output.csv` | Power BI 4-panel founder dashboard |

---

## 📁 File 1 — Raw Dataset

### `customer_shopping_data.csv`

> Original raw customer dataset containing **3,900+ customer records** with transactional, demographic, and behavioral attributes used as the foundation for the analysis pipeline.

#### Dataset Dimensions

| Property | Value |
|---|---|
| Total Records | 3,900+ customers |
| Geographic Coverage | 50 US states |
| Product Categories | Clothing, Footwear, Outerwear, Accessories |
| Seasons | Spring, Summer, Fall, Winter |
| Data Type | Transactional + Demographic + Behavioral |

#### Column Reference

| Column | Type | Description |
|---|---|---|
| `Customer ID` | Integer | Unique customer identifier |
| `Age` | Integer | Customer age |
| `Gender` | String | Male / Female |
| `Item Purchased` | String | Specific product name |
| `Category` | String | Clothing / Footwear / Outerwear / Accessories |
| `Purchase Amount (USD)` | Float | Transaction value in USD |
| `Location` | String | US state |
| `Size` | String | XS / S / M / L / XL |
| `Color` | String | Product color |
| `Season` | String | Spring / Summer / Fall / Winter |
| `Review Rating` | Float | Customer review score (1–5) |
| `Subscription Status` | String | Yes / No |
| `Payment Method` | String | Credit Card / PayPal / Cash etc. |
| `Shipping Type` | String | Standard / Express / Free etc. |
| `Discount Applied` | String | Yes / No |
| `Promo Code Used` | String | Yes / No |
| `Previous Purchases` | Integer | Count of past purchases |
| `Preferred Payment Method` | String | Customer's preferred payment type |
| `Frequency of Purchases` | String | Weekly / Monthly / Annually etc. |

#### Key Observations

```
⚠️  Column 'Purchase Amount (USD)' contains special characters
    → Renamed to 'Purchase_Amount_USD' before SQL analysis
    → ALTER TABLE d2c_customers
      RENAME COLUMN `Purchase_Amount_(USD)` TO `Purchase_Amount_USD`;
```

---

## 📁 File 2 — Processed Analytical Dataset

### `refined_customer_intelligence_engine_output.csv`

> Processed analytical dataset generated after Python-based preprocessing, feature engineering, segmentation logic, and customer intelligence scoring. This is the **primary source** for all SQL queries and Power BI visuals.

#### Engineered Features

| Feature | Formula / Logic | Range | Business Purpose |
|---|---|---|---|
| `Loyalty_Score_A` | Behavioral signals — frequency + satisfaction − promo use | 0 – 1 | Measures repeat purchase loyalty |
| `Loyalty_Score_B` | Commercial signals — spend + purchase history | 0 – 1 | Measures revenue-based loyalty |
| `Promo_Dependency_Score` | 0 = organic / 0.5 = sometimes / 1 = always promo | 0, 0.5, 1 | Identifies discount-reliant customers |
| `Purchase_Intensity_Score` | Previous Purchases / max purchases in dataset | 0 – 1 | Normalized repeat purchase rate |
| `Review_Satisfaction_Score` | Review Rating / 5 | 0 – 1 | Customer satisfaction proxy |
| `Master_Customer_Segment` | Rule-based classification using score combinations | 6 labels | Strategic customer grouping |
| `Customer_Value_Tier` | pd.qcut on Purchase Amount | Low / Mid / High | Revenue tier classification |

#### Master Customer Segment Labels

| Segment | Promo Dependency | Loyalty | Count | % of Base |
|---|---|---|---|---|
| 🟢 Premium Loyalists | 0.00 | 0.80 | 1,420 | 36.7% |
| 🟡 Emotionally Loyal | 0.00 | 0.67 | 331 | 8.6% |
| 🟡 Moderate Customers | 0.00 | 0.60 | 472 | 12.2% |
| 🔴 Discount Survivors | 1.00 | 0.50 | 1,640 | 42.5% |

#### Key Metrics from Processed Dataset

```
Retention Health Score     →  0.56 / 1.0
Promo Dependency Risk      →  0.43
Premium Loyalist %         →  36.7%
Organic Demand Regions     →  14 US states
Top Organic Region         →  Alaska (promo dep. 0.40)
Strongest Retention Cat.   →  Outerwear
```

#### This dataset is the source for:

```
SQL/queries.sql                         ← all 5 segmentation queries
PowerBI/Founder_Customer_Intelligence   ← all 4 dashboard panels
```

---

## 🔑 Key Difference Between Files

| | `customer_shopping_data.csv` | `customer_intelligence_final.csv` |
|---|---|---|
| **Stage** | Input — raw data | Output — engineered data |
| **Rows** | 3,900+ | Same rows |
| **Columns** | 19 original columns | 19 + 7 engineered features |
| **Used for** | Python processing | SQL + Power BI |
| **Contains segments** | ❌ No | ✅ Yes |
| **Contains scores** | ❌ No | ✅ Yes |

---

<div align="center">

**Part of the Founder Customer Intelligence System**
*Launched by IIIT Guwahati — Summer 2025*

</div>
