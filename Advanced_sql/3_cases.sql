/*
 Create tables from other tables
 Question
 Create 3 tables:
 Jan 2023 jobs
 Feb 2023 jobs
 Mar 2023 jobs
 Foreshadowing: This will be used in another practice problem below
 Hints:
 Use CREATE TABLES table_name AS syntax to create your table
 Look at a way to filter out only specific months (EXTRACT)
 */
--Create a table for Jan 2023 jobs
CREATE TABLE january_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 1;
--February
CREATE TABLE february_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 2;
--March
CREATE TABLE march_jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 3;
SELECT *
FROM march_jobs
LIMIT 10;
--CASE Expression
SELECT job_title_short,
    job_location
FROM job_postings_fact;
/*
 Label new column as follows:
 - 'Anywhere' jobs as 'Remote'
 - 'New York, NY' jobs as 'Local'
 - Otherwise 'Onsite'
 */
SELECT job_title_short,
    job_location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
LIMIT 20;
--To show the count per location category
SELECT count(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category
ORDER BY number_of_jobs desc
LIMIT 20;