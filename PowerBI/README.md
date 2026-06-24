# 📊 Power BI

<div align="center">

![PowerBI](https://img.shields.io/badge/Power%20BI-Founder%20Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Panels](https://img.shields.io/badge/Panels-4%20Dashboard%20Views-00C2D1?style=for-the-badge)
![Phase](https://img.shields.io/badge/Phase-Visualization%20%26%20Reporting-orange?style=for-the-badge)

**Interactive founder-level dashboard for customer retention intelligence, loyalty segmentation, and promotional dependency analysis.**

</div>

---

## 📄 Files

| File | Description |
|---|---|
| `Founder_Customer_Intelligence.pbix` | Main Power BI dashboard file — 4-panel founder intelligence report |
| `Dashboard_Screenshots/` | Static PNG exports of all dashboard panels |
| `README.md` | This file |

---

## 🖥️ Dashboard Overview

The Power BI report is a **2-page interactive dashboard** built on top of the Python-engineered customer intelligence dataset. It is designed for founder-level decision-making — not technical review.

---

### Page 1 — Cover Panel

> Entry screen for the report with project identity, team credits, and navigation.

| Element | Detail |
|---|---|
| Title | Founder Customer Intelligence System |
| Subtitle | Retention Strategy · Loyalty Intelligence · Promotional Dependency Analytics |
| Description | Strategic customer intelligence designed to identify loyalty strength, promotional dependency, and retention opportunities across customer segments and regions |
| Team | Akshit Sukhija → Product Intelligence & Strategic Analytics · Bhumika Singhal → Analytics Validation & Visualization |
| Footer | Powered by Python · SQL · Power BI |
| Navigation | CONTINUE button → leads to main dashboard |

<img width="1074" height="672" alt="image" src="https://github.com/user-attachments/assets/2fca4ddb-9a7c-4d17-ae1c-85976528867d" />


---

### Page 2 — Founder Intelligence Dashboard

> Core analytics panel with KPI cards, segment distribution, scatter analysis, retention funnels, and regional intelligence.

<img width="1075" height="673" alt="image" src="https://github.com/user-attachments/assets/315d8a05-7503-44d5-9b4d-aa4fdec39fa9" />



---

## 📐 Dashboard Structure

```
Founder_Customer_Intelligence.pbix
│
├── Page 1 — Cover Panel
│   ├── Project title and tagline
│   ├── Strategic description
│   ├── Team credits
│   └── CONTINUE navigation button
│
└── Page 2 — Founder Intelligence Dashboard
    ├── KPI Cards Row
    │   ├── Retention Health Score
    │   ├── Promo Dependency Risk
    │   ├── Premium Loyalist %
    │   └── Organic Demand Regions
    │
    ├── Customer Base Distribution (bar chart)
    ├── Organic Loyalty vs Discount Reliance (scatter plot)
    ├── Category Retention Funnel (horizontal bar chart)
    ├── Segment Intelligence Table
    ├── Top 10 Strategic Regions (bar chart)
    ├── Founder Risk Signals (text card)
    ├── Strategic Actions (text card)
    └── Slicers — Gender · Season · Category · Segment · Subscription Status
```

---

## 📊 KPI Cards

| KPI | Value | Meaning |
|---|---|---|
| **Retention Health Score** | 0.56 / 1.0 | Composite score measuring overall customer retention strength across the base |
| **Promo Dependency Risk** | 0.43 — Moderate | Average promotional reliance across all customers — flags margin risk |
| **Premium Loyalist %** | 36.4% (1,420 of 3,863) | Share of the customer base that purchases organically without discounts |
| **Organic Demand Regions** | 50 States (promo < 0.40) | Number of geographic markets showing below-threshold promotional dependency |

---

## 📈 Visuals Reference

### Customer Base Distribution
- **Type:** Horizontal bar chart
- **Dimension:** `Master_Customer_Segment`
- **Measure:** Count of Customers
- **Key Finding:** Discount Survivors are the largest segment at 43.0%, followed by Premium Loyalists at 36.4%

---

### Organic Loyalty vs Discount Reliance
- **Type:** Scatter plot
- **X-Axis:** Discount Reliance (`Promo_Dependency_Score`)
- **Y-Axis:** Organic Loyalty Strength (`Loyalty_Score_A`)
- **Color:** Segment
- **Quadrants:**

| Quadrant | Label | Segment |
|---|---|---|
| Top-Left | Core Retention Base | Premium Loyalists, Emotionally Loyal |
| Top-Right | Margin-Risk Loyalists | — |
| Bottom-Left | Low Engagement Base | Moderate Customers |
| Bottom-Right | Discount Survivors | Discount Survivors |

---

### Category Retention Funnel
- **Type:** Horizontal grouped bar chart
- **Dimension:** `Category` (Accessories, Footwear, Clothing, Outerwear)
- **Measure:** Purchase Intensity Score
- **Key Finding:** Outerwear leads with the highest purchase intensity (0.70), making it the strongest retention category

| Category | Purchase Intensity Score |
|---|---|
| Outerwear | 0.70 |
| Accessories | 0.66 |
| Clothing | 0.65 |
| Footwear | 0.63 |

---

### Segment Intelligence Table
- **Type:** Table visual
- **Columns:** Segment · Customers · Avg Organic Loyalty · Promo Risk · Avg Spend

| Segment | Customers | Avg Organic Loyalty | Promo Risk | Avg Spend |
|---|---|---|---|---|
| Discount Survivors | 1,677 | 0.50 | 1.00 | 59.28 |
| Emotionally Loyal | 331 | 0.67 | 0.00 | 58.21 |
| Moderate Customers | 472 | 0.60 | 0.00 | 61.29 |
| Premium Loyalists | 1,420 | 0.80 | 0.00 | 60.19 |

---

### Top 10 Strategic Regions
- **Type:** Horizontal bar chart
- **Dimension:** `Location`
- **Color Split:** Highly Promo Dependent (orange) vs Organically Motivated (green)
- **Ranked by:** Strategic Region Score
- **Top Regions:** Alaska · Arizona · Pennsylvania · West Virginia · Nevada · Washington

---

### Founder Risk Signals *(Text Card)*
```
Discount Survivors (1,640) create sustained margin instability — promo dependency 1.00.
Certain regions show strong spend but high promo reliance — fragile revenue.
Premium Loyalists show zero promo dependency — low-risk retention base.
```

---

### Strategic Actions *(Text Card)*
```
Reduce discounts in vulnerable segments.
Prioritize organic loyalty retention.
Expand into high-spend, low-promo regions.
```

---

### Slicers
Five interactive filters available at the bottom of the dashboard:

| Slicer | Field | Purpose |
|---|---|---|
| Gender | `Gender` | Filter by customer gender |
| Season | `Season` | Filter by purchase season |
| Category | `Category` | Filter by product category |
| Segment | `Master_Customer_Segment` | Filter by customer segment |
| Subscription Status | `Subscription_Status` | Filter by subscription type |

A **RESET** button clears all active slicer selections simultaneously.

---

## 🔗 Data Source

This dashboard is powered by the final output of the Python intelligence pipeline:

```
customer_intelligence_final.csv
→ Exported from: D2C_Customer_Intelligence_Engine.ipynb (Phase 5)
→ Also used by: SQL/queries.sql
```

**Import method:** Flat file import (CSV) into Power BI Desktop.

---

## 🎥 Demo

> Walkthrough Video --> https://drive.google.com/file/d/1i6_IYeS6NDcAG6gYhuDjB-J92qyIRDAh/view?usp=sharing



---

## 👥 Team

| Member | Role |
|---|---|
| Akshit Sukhija | Product Intelligence & Strategic Analytics — Python + SQL |
| Bhumika Singhal | Analytics Validation & Visualization — SQL + Power BI |

---
 
<div align="center">
**Part of the Founder Customer Intelligence System**
*Launched by IIIT Guwahati — Summer 2026*
 
</div>
