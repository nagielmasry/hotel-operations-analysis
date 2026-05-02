-- ============================================================
-- Task 3: Target Hotels for Service Improvement
-- Goal: Return Meal and Laundry service requests specifically
--       for branches in EMEA and LATAM regions
-- Output DataFrame: target_hotels
-- Note: Uses the ORIGINAL branch table (not Task 1 output)
-- ============================================================

SELECT
    s.description,       -- Service name (Meal or Laundry)
    b.id,                -- Branch identifier
    b.location,          -- Region (EMEA or LATAM)
    r.id AS request_id,  -- Individual request identifier
    r.rating             -- Customer satisfaction rating

FROM public.request r

    -- Join to get the service description (Meal, Laundry, etc.)
    JOIN public.service s  ON r.service_id = s.id

    -- Join to get the branch location (EMEA, LATAM, etc.)
    JOIN public.branch  b  ON r.branch_id  = b.id

-- Filter to only the two services management wants to improve
-- and only in the two target regions
WHERE s.description IN ('Meal', 'Laundry')
  AND b.location    IN ('EMEA', 'LATAM')

ORDER BY b.location, s.description, r.id;
