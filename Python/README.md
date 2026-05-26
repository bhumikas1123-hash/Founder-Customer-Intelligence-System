# 🐍 Python

<div align="center">

![Python](https://img.shields.io/badge/Python-3.x-yellow?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Pandas-Data%20Analysis-150458?style=for-the-badge&logo=pandas&logoColor=white)
![NumPy](https://img.shields.io/badge/NumPy-Feature%20Engineering-013243?style=for-the-badge&logo=numpy&logoColor=white)
![Phase](https://img.shields.io/badge/Phase-Data%20Engineering-00C2D1?style=for-the-badge)

**Data cleaning, feature engineering, segmentation logic and customer intelligence scoring for the D2C Customer Retention Intelligence Pipeline.**

</div>

---

## 📓 Notebook

### `D2C_Customer_Intelligence_Engine.ipynb`

> Builds a complete customer intelligence system capable of identifying loyal customers, promo-dependent customers, retention opportunities, high-value behavioral patterns and customer segments for strategic decision-making.

---

## 🏗️ Notebook Structure

```
D2C_Customer_Intelligence_Engine.ipynb
│
├── Phase 1 — Data Audit & Business Understanding
│   ├── Step 1A — Initial Dataset Inspection
│   ├── Step 1B — Data Quality Audit
│   └── Step 1C — Column Classification
│
├── Phase 2 — Customer Feature Engineering
│   ├── Feature 1 — Promo Dependency Score
│   ├── Feature 2 — Purchase Frequency Score
│   ├── Feature 3 — Customer Value Tier
│   ├── Feature 4 — Category Diversity
│   ├── Feature 5 — Average Order Value
│   ├── Feature 6 — Review Satisfaction Score
│   ├── Feature 7 — Loyalty Score A (Behavioral)
│   └── Feature 8 — Loyalty Score B (Commercial)
│
├── Phase 3 — Customer Segmentation
│   ├── Master Customer Segment Classification
│   ├── Segment Distribution Analysis
│   └── Segment-Level Business Summary
│
├── Phase 4 — Strategic Validation
│   ├── Promo Dependency Business Validation
│   ├── Loyalty vs Revenue Validation
│   └── Customer Value Validation
│
└── Phase 5 — Strategic Output
    ├── Founder-Level Strategic Insights
    ├── Retention Strategy Recommendations
    ├── Metric Refinement
    └── Final Dataset Export
```

---

## 📦 Libraries Used

| Library | Version | Purpose |
|---|---|---|
| `pandas` | Latest | Data loading, cleaning, transformation |
| `numpy` | Latest | Feature engineering, np.select segmentation |
| `Plotly` | Latest | Segment distribution visualizations |
| `seaborn` | Latest | Analytical charts |

---

## ⚙️ Phase 1 — Data Audit & Business Understanding

### Step 1A — Initial Dataset Inspection

Loaded the raw dataset and performed initial structural review:

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv('customer_intelligence_dataset.csv')

print(df.shape)        # dataset dimensions
print(df.columns)      # column names
df.head(10)            # first 10 records
df.info()              # data types
df.describe(all)       # statistical summary
```

### Step 1B — Data Quality Audit

Checked for missing values, duplicate rows and inconsistent fields:

```python
# Missing values
nulls = df.isnull().sum().sort_values(ascending=False)

# Duplicate records
duplicates = df.duplicated().sum()

# Unique values per column
df.nunique().sort_values()
```

### Step 1C — Column Classification

Mapped all 19 columns into business-relevant analytical groups:

| Group | Columns |
|---|---|
| Customer Attributes | Customer ID, Age, Gender, Subscription Status |
| Transaction Metrics | Purchase Amount (USD), Review Rating, Previous Purchases |
| Promotional Variables | Discount Applied, Promo Code Used |
| Product Variables | Item Purchased, Category, Size, Color, Season |
| Geography Variables | Location |
| Behavioral Signals | Frequency of Purchases |
| Operational Fields | Shipping Type, Payment Method |

---

## ⚙️ Phase 2 — Feature Engineering

8 business intelligence features engineered from raw columns:

### Feature Roadmap

| Feature | Business Purpose | Strategic Decision Enabled |
|---|---|---|
| `Promo_Dependency_Score` | Detect discount-reliant customers | Reduce unnecessary promotions |
| `Purchase_Intensity_Score` | Measure repeat purchasing intensity | Identify retention-worthy customers |
| `Customer_Value_Tier` | Classify customer commercial value | Prioritize high-value segments |
| `Category_Diversity` | Measure breadth of engagement | Design cross-sell strategies |
| `Average_Order_Value` | Understand spending quality | Identify premium customer groups |
| `Review_Satisfaction_Score` | Estimate satisfaction and engagement | Detect satisfaction quality |
| `Loyalty_Score_A` | Behavioral loyalty measurement | Detect organically loyal customers |
| `Loyalty_Score_B` | Commercial loyalty measurement | Detect revenue-driving customers |

---

### Feature 1 — Promo Dependency Score

**Business Meaning:** Measures how dependent a customer is on discounts and promo codes.

**Founder Decision Enabled:** Should the brand continue discounting this segment?

```python
df["Discount Applied"] = df["Discount Applied"].map({"Yes": 1, "No": 0})
df["Promo Code Used"]  = df["Promo Code Used"].map({"Yes": 1, "No": 0})

df["Promo_Dependency_Score"] = (
    df["Discount Applied"] + df["Promo Code Used"]
) / 2
```

| Score | Meaning |
|---|---|
| `0.0` | Never used discount or promo — organically loyal |
| `0.5` | Used one of the two — partially promo-driven |
| `1.0` | Used both always — fully discount-dependent |

---

### Feature 7 — Loyalty Score A (Behavioral)

**Business Meaning:** Measures repeat purchasing and engagement behavior independent of spend.

```python
df["Loyalty_Score_A"] = (
    df["Purchase_Intensity_Score"] * 0.5 +
    df["Review_Satisfaction_Score"] * 0.3 +
    (1 - df["Promo_Dependency_Score"]) * 0.2
)
```

| Weight | Component | Reason |
|---|---|---|
| 50% | Purchase Intensity | Frequency is the strongest loyalty signal |
| 30% | Review Satisfaction | Satisfaction drives organic retention |
| 20% | Promo Independence | Non-promo buyers are more genuinely loyal |

---

### Feature 8 — Loyalty Score B (Commercial)

**Business Meaning:** Measures revenue contribution and commercial value quality.

```python
df["Loyalty_Score_B"] = (
    df["Average_Order_Value_Normalized"] * 0.5 +
    df["Purchase_Intensity_Score"] * 0.3 +
    (1 - df["Promo_Dependency_Score"]) * 0.2
)
```

---

### Metric Renaming — Strategic Refinement

After validation, two metrics were renamed for analytical precision:

| Original Name | Refined Name | Reason |
|---|---|---|
| `Review_Engagement_Score` | `Review_Satisfaction_Score` | More accurate business meaning |
| `Purchase_Frequency_Score` | `Purchase_Intensity_Score` | Better reflects normalized repeat purchase rate |

---

## ⚙️ Phase 3 — Customer Segmentation

### Master Customer Segment Classification

Used `np.select()` to classify every customer into one of 6 strategic segments:

```python
conditions = [

    # Premium Loyalists
    (df["Loyalty_Score_A"] >= 0.70) &
    (df["Promo_Dependency_Score"] < 0.40),

    # Revenue-Driven Buyers
    (df["Loyalty_Score_B"] >= 0.70) &
    (df["Promo_Dependency_Score"] >= 0.40),

    # Emotionally Loyal
    (df["Loyalty_Score_A"] >= 0.70) &
    (df["Loyalty_Score_B"] < 0.70),

    # Discount Survivors
    (df["Promo_Dependency_Score"] >= 0.75),

    # At-Risk Customers
    (df["Loyalty_Score_A"] < 0.40) &
    (df["Purchase_Intensity_Score"] < 0.40)
]

labels = [
    "Premium Loyalists",
    "Revenue-Driven Buyers",
    "Emotionally Loyal",
    "Discount Survivors",
    "At-Risk Customers"
]

df["Master_Customer_Segment"] = np.select(
    conditions, labels, default="Moderate Customers"
)
```

### Segment Definitions

| Segment | Condition | Business Risk |
|---|---|---|
| 🟢 Premium Loyalists | Loyalty_A ≥ 0.70 AND Promo < 0.40 | Low — organic buyers |
| 🔵 Revenue-Driven Buyers | Loyalty_B ≥ 0.70 AND Promo ≥ 0.40 | Moderate — promo-assisted |
| 🟡 Emotionally Loyal | Loyalty_A ≥ 0.70 AND Loyalty_B < 0.70 | Low — brand affinity |
| 🔴 Discount Survivors | Promo_Dependency ≥ 0.75 | High — margin risk |
| ⚫ At-Risk Customers | Loyalty_A < 0.40 AND Intensity < 0.40 | High — churn risk |
| ⚪ Moderate Customers | Default (all others) | Moderate |

---

## ⚙️ Phase 4 — Strategic Validation

Three validation checks performed:

| Validation | Business Question | Method |
|---|---|---|
| Promo Dependency | Are high-spending customers genuinely loyal or promo-driven? | groupby segment → avg promo score |
| Loyalty vs Revenue | Do behavioral and commercial loyalty align? | groupby segment → Loyalty_A vs Loyalty_B |
| Customer Value | Which segments contribute strongest commercial value? | groupby segment → avg purchase amount |

---

## ⚙️ Phase 5 — Strategic Output

### Founder-Level Insights Generated

```
• Premium Loyalists generate sustainable long-term value with lower promotional dependency
• Revenue-Driven Buyers contribute strong commercial value but rely more on promotions
• Discount Survivors create short-term revenue while weakening long-term profitability
• Behavioral loyalty and commercial loyalty do not always align
• Retention strategies should differentiate emotional loyalty from promotion-driven buying
• Reducing discount exposure may improve margin quality without harming genuine loyalists
```

### Final Dataset Export

```python
df.to_csv('customer_intelligence_final.csv', index=False)
```

This processed file is used by:
- `SQL/queries.sql` — all 5 segmentation queries
- `PowerBI/Founder_Customer_Intelligence.pbix` — all 4 dashboard panels

---

## 👥 Team

| Member | Role |
|---|---|
| Akshit Sukhija | Product Intelligence & Strategic Analytics — Python + SQL |
| Bhumika | Analytics Validation & Visualization — SQL + Power BI |

---

<div align="center">

**Part of the Founder Customer Intelligence System**
*Launched by IIT Guwahati — Summer Project 2025*

</div>
