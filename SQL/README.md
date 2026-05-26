# 🗄️ SQL

<div align="center">

![SQL](https://img.shields.io/badge/SQL-Business%20Intelligence-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Queries](https://img.shields.io/badge/Queries-5%20Core%20%2B%201%20Bonus-00C2D1?style=for-the-badge)
![Phase](https://img.shields.io/badge/Phase-Analytics%20%26%20Segmentation-orange?style=for-the-badge)

**SQL-driven behavioral segmentation, promotional intelligence, and retention analytics for the D2C Customer Retention Intelligence Pipeline.**

</div>

---

## 📄 Files

| File | Description |
|---|---|
| `queries.sql` | All 5 core business intelligence queries + 1 bonus analysis |
| `D2C_SQL_Analysis_Report.pdf` | Full SQL analysis report with query results and business insights |
| `README.md` | This file |

---

## 🗂️ Source Table

```sql
-- Base table used across all queries
refined_customer_intelligence_engine_output  →  renamed as  d2c_customers
```

**Key Fields Used:**

| Field | Purpose |
|---|---|
| `Master_Customer_Segment` | Primary segmentation label from Python pipeline |
| `Loyalty_Score_A` | Behavioral loyalty (frequency + satisfaction + promo independence) |
| `Loyalty_Score_B` | Commercial loyalty (AOV + frequency + promo independence) |
| `Promo_Dependency_Score` | Discount reliance signal (0.0 = organic, 1.0 = fully promo-driven) |
| `Purchase_Amount_USD` | Transaction value |
| `Customer_Value_Tier` | High / Mid / Low commercial classification |
| `Location` | US state-level geography |
| `Gender`, `Season`, `Category` | Demographic and product dimensions |

---

## 🏗️ Query Structure

```
queries.sql
│
├── Query 1 — Loyal vs Promo Buyers
├── Query 2 — Customer Value Tier Breakdown
├── Query 3 — Geographic Demand Intelligence
├── Query 4 — Promotional Sunset Plan
├── Query 5 — Ideal Customer Profile (ICP)
└── Query + — Season × Category Tenure Analysis (Bonus)
```

---

## ⚙️ Query Reference

---

### Query 1 — Loyal vs Promo Buyers

**Business Question:** Who are genuinely loyal customers vs. those who only buy with discounts?

**SQL Techniques:** `AVG`, `COUNT`, `GROUP BY`, `ORDER BY`

**Key Result:**

| Segment | Customers | Avg Promo Dependency | Avg Behavioral Loyalty | Avg Spend |
|---|---|---|---|---|
| Premium Loyalists | 1420 | 0.00 | 0.80 | 60.19 |
| Emotionally Loyal | 331 | 0.00 | 0.67 | 58.21 |
| Moderate Customers | 472 | 0.00 | 0.60 | 61.29 |
| Discount Survivors | 1640 | 1.00 | 0.50 | 59.12 |

**Key Insights:**
- Premium Loyalists had near-zero promo dependency — they purchase because they genuinely value the brand
- Discount Survivors showed full promo dependency (1.00), indicating fragile conversion behavior
- Average spending alone was not sufficient to distinguish loyal customers from promo-driven buyers
- The strategic objective is not to eliminate promotions entirely, but to reduce unnecessary discount dependency while protecting long-term margin quality

**Business Action:** Reward loyal customers with exclusive perks. Design a gradual discount reduction strategy for discount-dependent segments.

---

### Query 2 — Customer Value Tier Breakdown

**Business Question:** What behavioral patterns predict high customer value over time?

**SQL Techniques:** `AVG`, `COUNT`, `GROUP BY`, `ORDER BY`

**Key Result:**

| Value Tier | Avg Purchase Intensity | Avg Satisfaction | Avg Promo Dependency | Avg Previous Purchases | Customer Count |
|---|---|---|---|---|---|
| Mid Value | 0.51 | 0.75 | 0.43 | 25.4 | 1288 |
| High Value | 0.51 | 0.75 | 0.42 | 25.3 | 1282 |
| Low Value | 0.51 | 0.75 | 0.43 | 25.3 | 1293 |

**Key Insights:**
- High, Mid, and Low value customers showed nearly identical behavioral scores across all dimensions
- Customer value tier alone does not predict loyalty or repeat purchasing behavior
- Some high-spending customers may still carry high promotional dependency

**Business Action:** Combine customer value, loyalty behavior, and promo dependency for smarter targeting — revenue-based segmentation alone is insufficient.

---

### Query 3 — Geographic Demand Intelligence

**Business Question:** Which geographies signal organic demand vs. discount-driven volume?

**SQL Techniques:** `AVG`, `COUNT`, `SUM`, `CASE`, `GROUP BY`, `ORDER BY`

**Key Result:**

| Location | Total Customers | Avg Spend | Avg Promo Dependency | Premium Loyalists | Premium % |
|---|---|---|---|---|---|
| Alaska | 72 | 67.60 | 0.40 | 30 | 41.7% |
| Pennsylvania | 74 | 66.57 | 0.45 | 30 | 40.5% |
| Arizona | 65 | 66.55 | 0.34 | 27 | 41.5% |
| West Virginia | 79 | 63.86 | 0.48 | 25 | 31.6% |
| Washington | 73 | 63.33 | 0.44 | 18 | 24.7% |

**Key Insights:**
- Arizona and Alaska showed higher average spending combined with lower promo dependency — signals of stronger organic brand demand
- Some regions showed strong revenue but high discount reliance, indicating fragile and margin-diluting sales
- High-spend, low-promo regions represent stronger long-term expansion candidates

**Business Action:** Increase marketing investment in organically strong regions. Apply careful, phased discount reduction in weaker regions. Use geography-based targeting strategies.

---

### Query 4 — Promotional Sunset Plan

**Business Question:** How should the brand restructure its promotional strategy to protect margins?

**SQL Techniques:** `AVG`, `COUNT`, `CASE`, `GROUP BY`, `ORDER BY`

**Key Result:**

| Segment | Customer Count | Avg Promo Dependency | Avg Spend | Behavioral Loyalty | Promo Recommendation |
|---|---|---|---|---|---|
| Discount Survivors | 1640 | 1.00 | 59.12 | 0.50 | Sunset Discounts — Low loyalty risk |
| Premium Loyalists | 1420 | 0.00 | 60.19 | 0.80 | Protect — Organically loyal, no discounts needed |
| Moderate Customers | 472 | 0.00 | 61.29 | 0.60 | Protect — Organically loyal, no discounts needed |
| Emotionally Loyal | 331 | 0.00 | 58.21 | 0.67 | Protect — Organically loyal, no discounts needed |

**CASE Logic Used:**

```sql
CASE
    WHEN AVG(Promo_Dependency_Score) >= 0.75 AND AVG(Loyalty_Score_A) < 0.50
        THEN 'Sunset Discounts — Low loyalty risk'
    WHEN AVG(Promo_Dependency_Score) >= 0.50 AND AVG(Loyalty_Score_A) >= 0.50
        THEN 'Reduce Gradually — Monitor retention'
    WHEN AVG(Promo_Dependency_Score) < 0.40
        THEN 'Protect — Organically loyal, no discounts needed'
    ELSE 'Review Case by Case'
END AS promo_recommendation
```

**Three Strategic Groups:**

| Group | Condition | Action |
|---|---|---|
| 🔴 Sunset Discounts | Low loyalty + High promo dependency | Gradually remove discount access |
| 🟡 Reduce Gradually | Medium loyalty + Medium promo dependency | Monitor and phase discounts out slowly |
| 🟢 Protect Loyal | Naturally loyal buyers | No discounts needed; invest in perks instead |

**Business Action:** Implement a phased discount reduction strategy by segment to improve profit margins without damaging genuine customer retention.

---

### Query 5 — Ideal Customer Profile (ICP)

**Business Question:** What does the brand's best customer actually look like?

**SQL Techniques:** `AVG`, `COUNT`, `WHERE`, `GROUP BY`, `ORDER BY`, `LIMIT`

**Key Result (Top Profiles from Premium Loyalists):**

| Gender | Avg Age | Location | Category | Sub Status | Season | Avg Spend | Avg Purchases | Behavioral Loyalty |
|---|---|---|---|---|---|---|---|---|
| Male | 46.0 | Arizona | Footwear | No | Summer | 100.00 | 49.0 | 0.98 |
| Female | 22.0 | Hawaii | Outerwear | No | Fall | 100.00 | 42.0 | 0.87 |
| Female | 28.0 | Arizona | Outerwear | No | Fall | 100.00 | 48.0 | 0.85 |
| Female | 45.0 | New Mexico | Clothing | No | Spring | 100.00 | 33.0 | 0.85 |
| Male | 20.0 | North Dakota | Outerwear | No | Summer | 100.00 | 42.0 | 0.82 |

**Key Insights:**
- Top ICP profiles are concentrated in states like Arizona, Hawaii, and New Mexico
- Outerwear and Footwear dominate premium loyal purchasing behavior
- High behavioral loyalty (0.82–0.98) combined with maximum spend ($100) identifies the strongest customer persona
- Non-subscribers show up consistently in top ICP rows, suggesting the brand's best customers don't rely on subscription incentives

**Business Action:** Use this profile to build targeted ad audiences, personalized retention campaigns, and acquisition lookalike strategies.

---

### Query + — Season × Category Tenure Analysis *(Bonus — Beyond Scope)*

**Business Question:** Which seasons and categories attract new vs. established repeat customers?

**SQL Techniques:** `AVG`, `COUNT`, `CASE`, `GROUP BY`, `ORDER BY`

**Key Result:**

| Season | Category | Avg Previous Purchases | Avg Promo Dependency | Customer Count | Tenure Group |
|---|---|---|---|---|---|
| Winter | Footwear | 26.8 | 0.40 | 139 | Higher Tenure |
| Summer | Accessories | 26.7 | 0.42 | 309 | Higher Tenure |
| Spring | Outerwear | 26.1 | 0.40 | 80 | Higher Tenure |
| Winter | Clothing | 26.0 | 0.42 | 443 | Higher Tenure |
| Spring | Accessories | 25.7 | 0.46 | 298 | Higher Tenure |

**Tenure Classification Logic:**

```sql
CASE
    WHEN AVG(Previous_Purchases) < 10 THEN 'Lower Tenure'
    ELSE 'Higher Tenure'
END AS tenure_group
```

**Key Insights:**
- Winter Footwear and Summer Accessories attract the highest-tenure repeat buyers
- All top season-category combinations fall into the Higher Tenure group with 25–27 average previous purchases
- Lower promo dependency in high-tenure combinations confirms that long-term customers are less discount-reliant

**Business Action:** Focus retention campaigns around Winter Footwear and Summer Accessories. Use these categories as loyalty anchors for cross-sell strategies.

---

## 🧠 Methodology Notes

**Threshold Design Philosophy:**

Segmentation thresholds were intentionally designed as **strategic heuristics** rather than statistically optimized cutoffs. The objective was:

- Behavioral interpretability over scoring complexity
- Founder-level usability and decision clarity
- Retention action support without technical overhead

This ensures the analysis remains accessible and actionable for non-technical business stakeholders.

---

## 📊 Segment Reference

| Segment | Condition | Business Risk |
|---|---|---|
| 🟢 Premium Loyalists | Loyalty_A ≥ 0.70 AND Promo < 0.40 | Low — organic buyers |
| 🔵 Revenue-Driven Buyers | Loyalty_B ≥ 0.70 AND Promo ≥ 0.40 | Moderate — promo-assisted |
| 🟡 Emotionally Loyal | Loyalty_A ≥ 0.70 AND Loyalty_B < 0.70 | Low — brand affinity |
| 🔴 Discount Survivors | Promo_Dependency ≥ 0.75 | High — margin risk |
| ⚫ At-Risk Customers | Loyalty_A < 0.40 AND Intensity < 0.40 | High — churn risk |
| ⚪ Moderate Customers | Default (all others) | Moderate |

---

## 🎯 Recommended Next Steps

| Priority | Action | Segment / Market | Expected Impact |
|---|---|---|---|
| 🔴 HIGH | Sunset discounts for highly promo-dependent customers | Discount Survivors | Improve profit margins and reduce discount dependency |
| 🔴 HIGH | Launch VIP rewards and early-access programs | Premium Loyalists | Increase retention, referrals, and customer lifetime value |
| 🔴 HIGH | Increase marketing investment in high organic-demand regions | Arizona, Alaska | Strengthen brand-led growth and improve acquisition efficiency |
| 🟡 MEDIUM | Rebuild customer targeting using behavioral segmentation | All Customer Tiers | Improve campaign personalization and targeting accuracy |
| 🟡 MEDIUM | Optimize seasonal product promotions strategically | All Seasons & Categories | Reduce unnecessary promotions and improve revenue quality |
| 🟢 LOW | Monitor emotionally loyal niche customers separately | Emotionally Loyal Segment | Preserve long-term loyalty and niche customer retention |

---

## 👥 Team

| Member | Role |
|---|---|
| Akshit Sukhija | Product Intelligence & Strategic Analytics — Python + SQL |
| Bhumika Singhal | Analytics Validation & Visualization — SQL + Power BI |

---

<div align="center">

**Part of the Founder Customer Intelligence System**
*Launched by IIT Guwahati — Summer Project 2025*

</div>
