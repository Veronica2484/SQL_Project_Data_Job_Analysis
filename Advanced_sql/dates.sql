SELECT '2023-02-19'::DATE,
    '123'::INTEGER,
    'true'::BOOLEAN,
    '3.14'::REAL;
SELECT job_title_short AS title,
    job_location AS location,
    job_posted_date AS DATE
FROM job_postings_fact;
--If I only want the date type instead of the timestamp
SELECT job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS DATE
FROM job_postings_fact;
--at time zone
SELECT job_title_short AS title,
    job_location AS location,
    job_posted_date at time zone 'UTC' AT TIME ZONE 'EST' AS DATE
FROM job_postings_fact
LIMIT 5;
--Extract
SELECT job_title_short AS title,
    job_location AS location,
    job_posted_date at time zone 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT (
        MONTH
        from job_posted_date
    ) as date_month,
    EXTRACT (
        YEAR
        from job_posted_date
    ) as date_year
FROM job_postings_fact
LIMIT 5;
--In order to check the tren of job posting
SELECT COUNT(job_id) as job_posted_count,
    EXTRACT(
        MONTH
        from job_posted_date
    ) AS date_month
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY date_month
ORDER BY job_posted_count DESC;