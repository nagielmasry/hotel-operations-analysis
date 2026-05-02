-- ============================================================
-- Task 2: Response Time Analysis by Branch and Service
-- Goal: Calculate average and maximum time_taken for every
--       branch/service combination to identify performance gaps
-- Output DataFrame: average_time_service
-- ============================================================

SELECT
    service_id,
    branch_id,

    -- Average response time rounded to 2 decimal places
    ROUND(AVG(time_taken), 2) AS avg_time_taken,

    -- Maximum response time recorded for this branch/service combination
    MAX(time_taken)           AS max_time_taken

FROM public.request

-- GROUP BY both columns so aggregations are calculated
-- per unique branch and service combination
GROUP BY service_id, branch_id

-- Ordered to make output easy to read and compare across branches
ORDER BY service_id, branch_id;
