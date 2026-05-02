[README.md](https://github.com/user-attachments/files/27307702/README.md)
# 🏨 Hotel Operations Analysis (SQL)

## 🚀 Overview

This project is a **SQL-based operational analysis** for **LuxurStay Hotels**, a major international hotel chain operating across multiple regions worldwide.

Management has been receiving complaints about **slow room service response times**, causing customer satisfaction to drop below their 4.5 target rating. This project uses SQL to investigate the root causes, identify underperforming branches and services, and surface the data needed to drive operational improvements.

---

## 🎯 Project Objectives

- Clean and validate the raw branch data to ensure analysis accuracy
- Measure response time performance across every branch and service combination
- Identify the specific services and regions where improvements are most needed
- Flag every branch/service combination falling below the 4.5 satisfaction target

---

## 🧠 Business Questions Answered

✔ What data quality issues exist in the branch table, and how can they be fixed?  
✔ Which branch and service combinations have the **highest average response times**?  
✔ Which **Meal and Laundry** services in **EMEA and LATAM** need attention?  
✔ Which branch/service combinations are **below the 4.5 rating target** set by management?

---

## 🏗️ Tech Stack

- **SQL (PostgreSQL)** → Data cleaning, joins, aggregations, and filtering
- **DataLab (DataCamp)** → Query execution environment

---

## 🔍 SQL Skills Demonstrated

- 🧹 **Data Cleaning** → NULLs, placeholders (`-`), typos, case variants, out-of-range values
- 🔗 **Multi-table Joins** → Combining `branch`, `request`, and `service` tables
- 📊 **Aggregations** → `AVG`, `MAX`, `COUNT`, `GROUP BY`
- 🔢 **Rounding** → `ROUND` to specified decimal places
- 🧮 **Conditional Logic** → `CASE WHEN`, `COALESCE`, `NULLIF`, regex validation
- ✂️ **String Manipulation** → `TRIM`, `UPPER`, `LOWER` for standardisation
- 🔍 **Filtered Analysis** → `WHERE IN`, `HAVING` for targeted results

---

## 📁 Project Structure

```
hotel-operations-analysis/
│
├── README.md
│
├── queries/
│   ├── task1_clean_branch_data.sql     → Clean and validate the branch table
│   ├── task2_response_time.sql         → Avg & max response time per branch/service
│   ├── task3_target_hotels.sql         → Meal & Laundry in EMEA and LATAM
│   └── task4_below_target_rating.sql   → Branch/service combos below 4.5 rating
│
└── data/
    └── schema.md                       → Full table schema and column descriptions
```

---

## 📋 Dataset — Three Linked Tables

### `branch` Table
| Column | Type | Description |
|---|---|---|
| `id` | integer | Unique hotel branch identifier |
| `location` | text | Region: EMEA, NA, LATAM, APAC |
| `total_rooms` | integer | Total number of rooms (1–400) |
| `staff_count` | integer | Number of service department staff |
| `opening_date` | text | Year hotel opened (2000–2023), stored as text |
| `target_guests` | text | Primary guest type: Leisure or Business |

### `request` Table
| Column | Type | Description |
|---|---|---|
| `id` | integer | Unique request identifier |
| `service_id` | integer | Foreign key → service table |
| `branch_id` | integer | Foreign key → branch table |
| `time_taken` | integer | Minutes taken to fulfil the request |
| `request_time` | text | Time of day: Day-Peak, Day-Off-Peak, Night |
| `rating` | integer | Customer satisfaction rating (1–5) |

### `service` Table
| Column | Type | Description |
|---|---|---|
| `id` | integer | Unique service identifier |
| `description` | text | Service type: Meal, Laundry, Cleaning, Other |

---

## 🧹 Data Cleaning Summary (Task 1)

| Column | Issue Found | Fix Applied |
|---|---|---|
| `location` | No issues — all valid | `UPPER(TRIM())` applied for consistency |
| `total_rooms` | NULLs and out-of-range values | Out-of-range or NULL → default `100` |
| `staff_count` | NULL values | NULL → `total_rooms * 1.5`, cast to integer |
| `opening_date` | `'-'` placeholder (4 rows), stored as TEXT | `NULLIF` to catch `'-'`, then cast; invalid → `2023` |
| `target_guests` | `'B.'` (12 rows), `'Busniess'` typo (1 row) | `LOWER(TRIM())` comparison → replace both with `'Leisure'` |

---

## 📊 Key Findings

### Response Time by Branch & Service (Task 2)
Calculating average and maximum response time per branch/service combination allows management to pinpoint which hotels are consistently slow versus which have occasional spikes.

### Meal & Laundry in EMEA and LATAM (Task 3)
Management targeted these two service types and two regions for priority improvement. The query joins all three tables to return the exact requests of interest with their ratings.

### Below-Target Rating Combinations (Task 4)
Using `HAVING AVG(rating) < 4.5` filters down to only the branch/service combinations falling below the management benchmark — giving the operations team a clear action list.

---

## ▶️ How to Use

1. Clone or download this repository
2. Review `data/schema.md` for the full table and relationship descriptions
3. Run queries in order from `task1` through `task4` in any PostgreSQL environment
4. Each file is fully self-contained with section headings and inline comments

---

## 👤 Nagi El-Masry 

Data Analyst | SQL · Data Cleaning · Joins · Aggregations · Business Analytics
