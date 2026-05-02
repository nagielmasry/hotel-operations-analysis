-- ============================================================
-- Task 4: Identify Low-Performing Branch & Service Combinations
-- Goal: Return only the branch/service combos where the average
--       rating falls below the 4.5 management target
-- Output DataFrame: average_rating
-- ============================================================

SELECT
    service_id,
    branch_id,

    -- Average rating rounded to 2 decimal places
    ROUND(AVG(rating), 2) AS avg_rating

FROM public.request

-- GROUP BY to calculate average rating per branch/service combination
GROUP BY service_id, branch_id

-- HAVING filters AFTER grouping — this is required when filtering
-- on aggregate functions like AVG(). WHERE cannot be used here.
-- Only combinations below the 4.5 management target are returned.
HAVING ROUND(AVG(rating), 2) < 4.5

-- Worst performers at the top for easy prioritisation
ORDER BY avg_rating ASC;
