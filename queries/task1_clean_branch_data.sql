-- ============================================================
-- Task 1: Data Cleaning Query for the branch Table
-- Goal: Return a clean version of branch data named
--       'clean_branch_data' WITHOUT modifying the original table
--
-- Dirty values confirmed from raw data inspection:
--   opening_date  → '-' (4 rows)           replace with 2023
--   target_guests → 'B.' (12 rows)          replace with 'Leisure'
--   target_guests → 'Busniess' (1 row typo) replace with 'Leisure'
-- ============================================================

SELECT

    -- No cleaning needed; primary key, never null
    id,

    -- UPPER + TRIM applied for string standardization
    -- All 4 valid values (EMEA, NA, LATAM, APAC) already clean in raw data
    UPPER(TRIM(location)) AS location,

    -- Must be a positive integer between 1 and 400
    -- NULL or out-of-range values replaced with default of 100
    CASE
        WHEN total_rooms IS NULL       THEN 100
        WHEN total_rooms < 1
          OR total_rooms > 400         THEN 100
        ELSE total_rooms
    END AS total_rooms,

    -- NULL staff_count replaced with total_rooms * 1.5
    -- Cast to INTEGER because staff count is a discrete value (no decimals)
    -- Falls back to 100 * 1.5 = 150 if total_rooms is also invalid
    CASE
        WHEN staff_count IS NULL THEN
            CASE
                WHEN total_rooms IS NULL
                  OR total_rooms < 1
                  OR total_rooms > 400  THEN CAST(ROUND(100 * 1.5) AS INTEGER)
                ELSE                        CAST(ROUND(total_rooms * 1.5) AS INTEGER)
            END
        ELSE staff_count
    END AS staff_count,

    -- opening_date is stored as TEXT and contains '-' as a placeholder
    -- NULLIF converts '-' to NULL cleanly before any casting is attempted
    -- TRIM removes whitespace; regex not needed since NULLIF handles '-'
    -- Out-of-range or invalid values replaced with 2023
    CASE
        WHEN opening_date IS NULL
          OR NULLIF(TRIM(opening_date), '-') IS NULL       THEN 2023
        WHEN CAST(TRIM(opening_date) AS INTEGER) < 2000
          OR CAST(TRIM(opening_date) AS INTEGER) > 2023   THEN 2023
        ELSE CAST(TRIM(opening_date) AS INTEGER)
    END AS opening_date,

    -- LOWER + TRIM used for safe case-insensitive comparison
    -- Catches all dirty variants: 'B.' → Leisure, 'Busniess' (typo) → Leisure
    -- Only confirmed 'leisure' or 'business' matches are kept as valid values
    CASE
        WHEN LOWER(TRIM(target_guests)) = 'leisure'  THEN 'Leisure'
        WHEN LOWER(TRIM(target_guests)) = 'business' THEN 'Business'
        ELSE                                              'Leisure'
    END AS target_guests

FROM public.branch;
